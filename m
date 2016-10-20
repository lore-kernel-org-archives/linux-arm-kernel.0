From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Thu, 20 Oct 2016 17:21:23 +0200
Subject: [PATCH 1/4] ARM: dts: stm32f429: Align Ethernet node with new
 bindings properties
In-Reply-To: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
References: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1476976886-23781-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch aligns clocks names and node reference according to new
stm32-dwmac glue binding. It also renames Ethernet pinctrl phandle
(indeed there is no need to add 0 as Ethernet instance as there is only
one IP in SOC).

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 336ee4f..6350117b 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -313,7 +313,7 @@
 				};
 			};
 
-			ethernet0_mii: mii at 0 {
+			ethernet_mii: mii at 0 {
 				pins {
 					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
 						 <STM32F429_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
@@ -373,13 +373,13 @@
 			st,mem2mem;
 		};
 
-		ethernet0: dwmac at 40028000 {
+		mac: ethernet at 40028000 {
 			compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";
 			reg = <0x40028000 0x8000>;
 			reg-names = "stmmaceth";
 			interrupts = <61>, <62>;
 			interrupt-names = "macirq", "eth_wake_irq";
-			clock-names = "stmmaceth", "tx-clk", "rx-clk";
+			clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
 			clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
 			st,syscon = <&syscfg 0x4>;
 			snps,pbl = <8>;
-- 
1.9.1
