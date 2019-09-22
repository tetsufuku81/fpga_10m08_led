-------------------------------------------------------------------------------
-- Project   : MAX10 Evaluation Kit
-- File      : max10evb_test1.vhd
-- Title     : Top
--------------------------------------------------------------------------------
--+-----+-----------+-----------------------------------------------------------
-- Ver   Date        Description
--+-----+-----------+-----------------------------------------------------------
-- 00.00 2019/06/27  Created
--+-----+-----------+-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity max10evb_test1 is
  PORT
  (
    clk       : in  std_logic;      -- 50MHz
    rst_n     : in  std_logic;      -- リセット(負論理)
    led_o     : out std_logic       -- LED制御(正論理)
  );
end max10evb_test1;


architecture rtl of max10evb_test1 is
------------------------------------------------------------
-- 変数宣言
------------------------------------------------------------
-- カウンタ
signal count_100us          : std_logic_vector(11 downto 0);
signal count_1s             : std_logic_vector(13 downto 0);   
signal led                  : std_logic;


begin


------------------------------------------------------------
-- 100usカウンタ
------------------------------------------------------------
process (rst_n, clk)
begin
if (rst_n = '0') then
  count_100us <= (others => '0');
  
elsif (clk'event and clk = '1') then
  if (count_100us = "100101011111") then
    count_100us <= (others => '0');
  else
    count_100us <= count_100us + 1;
  end if;
  
end if;
end process;


------------------------------------------------------------
-- 1sカウンタ
------------------------------------------------------------
process (rst_n, clk)
begin
if (rst_n = '0') then
  count_1s <= (others => '0');
  
elsif (clk'event and clk = '1') then
  if (count_100us = "100101011111") then
  
    if (count_1s = "10011100001111") then
      count_1s <= (others => '0');
    else
      count_1s <= count_1s + 1;
    end if;
    
  end if;
end if;
end process;


------------------------------------------------------------
-- LED制御
------------------------------------------------------------
process (rst_n, clk)
begin
if (rst_n = '0') then
  led <= '0';
elsif (clk'event and clk = '1') then
  if (count_100us = "100101011111") then
    if (count_1s = "10011100001111") then
      led <= not led;
    end if;
  end if;
end if;
end process;


------------------------------------------------------------
-- 出力FF
------------------------------------------------------------
process (rst_n, clk)
begin
if (rst_n = '0') then
  led_o <= '0';
  
elsif (clk'event and clk = '1') then
  led_o <= led;
  
end if;
end process;


end rtl;
