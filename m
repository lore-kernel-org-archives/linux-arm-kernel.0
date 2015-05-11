From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 May 2015 15:26:17 +0200
Subject: [PATCH 1/2] ARM: at91/dt: sama5d4: add usart0, usart1 dt nodes
Message-ID: <1431350778-27023-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Also add the pinctrl for usart0, usart1.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 6b1bb58f9c0b..9900abc5f00c 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -59,6 +59,8 @@
 		serial0 = &usart3;
 		serial1 = &usart4;
 		serial2 = &usart2;
+		serial3 = &usart0;
+		serial4 = &usart1;
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
@@ -977,6 +979,42 @@
 				reg = <0xf8028000 0x60>;
 			};
 
+			usart0: serial at f802c000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf802c000 0x100>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(36))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(37))>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts &pinctrl_usart0_cts>;
+				clocks = <&usart0_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
+			usart1: serial at f8030000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8030000 0x100>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(38))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(39))>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts &pinctrl_usart1_cts>;
+				clocks = <&usart1_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
 			mmc1: mmc at fc000000 {
 				compatible = "atmel,hsmci";
 				reg = <0xfc000000 0x600>;
@@ -1623,6 +1661,36 @@
 					};
 				};
 
+				usart0 {
+					pinctrl_usart0: usart0-0 {
+						atmel,pins =
+							<AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_NONE		/* RXD */
+							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* TXD */
+							>;
+					};
+					pinctrl_usart0_rts: usart0_rts-0 {
+						atmel,pins = <AT91_PIOD 11 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+					pinctrl_usart0_cts: usart0_cts-0 {
+						atmel,pins = <AT91_PIOD 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+				};
+
+				usart1 {
+					pinctrl_usart1: usart1-0 {
+						atmel,pins =
+							<AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_NONE		/* RXD */
+							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* TXD */
+							>;
+					};
+					pinctrl_usart1_rts: usart1_rts-0 {
+						atmel,pins = <AT91_PIOD 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+					pinctrl_usart1_cts: usart1_cts-0 {
+						atmel,pins = <AT91_PIOD 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+					};
+				};
+
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-- 
2.1.3
