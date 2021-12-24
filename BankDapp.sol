// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract BankDapp {
    struct kyc {
        uint customerID; 
        string fullname;
        string profession;
        string DateOfBirth;
        address WalletAddress;     
    }
    string public bank_name;
    string public bank_address;
    uint public number_of_accounts=0; 
    mapping(address => uint256) balanceOf; 
    mapping(address=>kyc) acctInfo;
    //mapping(address => kyc) public clientRecords;
    modifier onlyRegistered(address sAddress) {
        require(acctInfo[sAddress].customerID > 0,"Not a registerd account");
        _;
    }
function register_account (string memory fullname, string memory profession, string memory DateOfBirth) public {
        require (acctInfo[msg.sender].customerID == 0,"This is person exists");
        kyc memory newClient;
        newClient.fullname=fullname;
        newClient.profession=profession;
        newClient.DateOfBirth=DateOfBirth;
        newClient.WalletAddress=msg.sender;
        number_of_accounts++;
        newClient.customerID=number_of_accounts;
        acctInfo[msg.sender]=newClient;
    }
    function getAccountInfo(address userAddress) public view onlyRegistered(userAddress) onlyRegistered(msg.sender)  returns (kyc memory)  {
        return acctInfo[userAddress]; 
    }

    function account_balance() public view returns (uint){
        return balanceOf[msg.sender];
    }
    constructor(){
       bank_address="2021 Techup";
       bank_name="First Decentralized bank of Techup";
    
    }
function transfer(uint amount,address receivwAddr) public payable onlyRegistered(msg.sender) onlyRegistered(receivwAddr) {
        require(balanceOf[msg.sender] > amount,"balance not enough");
        balanceOf[msg.sender] -=amount;
        balanceOf[receivwAddr] +=amount;
    }

   function withdrawl(uint amount) public payable onlyRegistered(msg.sender) {
       address payable pAdd = payable(msg.sender);
        pAdd.transfer(amount);
    }

    receive() external payable onlyRegistered(msg.sender) {
       balanceOf[msg.sender] +=msg.value;
    }
    
}
