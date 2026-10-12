create database textile;
use textile;
show tables;

ALTER TABLE customers MODIFY Customer_ID VARCHAR(20) NOT NULL,ADD CONSTRAINT pk_customers
PRIMARY KEY (Customer_ID);

ALTER TABLE products MODIFY Product_ID VARCHAR(20) NOT NULL,ADD CONSTRAINT pk_products
PRIMARY KEY (Product_ID);

ALTER TABLE branches MODIFY Branch_ID VARCHAR(20) NOT NULL,ADD CONSTRAINT pk_branches
PRIMARY KEY (Branch_ID);

ALTER TABLE sales MODIFY Transaction_ID VARCHAR(30) NOT NULL,MODIFY Customer_ID VARCHAR(20) NOT NULL,
MODIFY Product_ID VARCHAR(20) NOT NULL,MODIFY Branch_ID VARCHAR(20) NOT NULL,ADD CONSTRAINT pk_sales
PRIMARY KEY (Transaction_ID),ADD CONSTRAINT fk_customer FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID),ADD CONSTRAINT fk_product FOREIGN KEY (Product_ID)
REFERENCES products(Product_ID),ADD CONSTRAINT fk_branch FOREIGN KEY (Branch_ID)
REFERENCES branches(Branch_ID);

SELECT SUM(Net_Amount_INR) AS Total_Revenue FROM sales;

SELECT p.Product_Name, SUM(s.Net_Amount_INR) Revenue FROM sales s
JOIN products p ON s.Product_ID = p.Product_ID GROUP BY p.Product_Name
ORDER BY Revenue DESC LIMIT 10;

SELECT b.Branch_Name,SUM(s.Net_Amount_INR) Revenue FROM sales s
JOIN branches b ON s.Branch_ID = b.Branch_ID GROUP BY b.Branch_Name
ORDER BY Revenue DESC;

SELECT c.Gender,SUM(s.Net_Amount_INR) Revenue FROM sales s
JOIN customers c ON s.Customer_ID = c.Customer_ID GROUP BY c.Gender;