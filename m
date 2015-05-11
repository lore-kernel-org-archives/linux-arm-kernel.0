From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 May 2015 15:26:18 +0200
Subject: [PATCH 2/2] ARM: at91/dt: sama5d4: add uart0, uart1 dt nodes
In-Reply-To: <1431350778-27023-1-git-send-email-nicolas.ferre@atmel.com>
References: <1431350778-27023-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1431350778-27023-2-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suchang Ko <suchangko@samul.kr>

Add sama5d4 uart0, uart1 dt nodes, pinctrl and related aliases.

Signed-off-by: Suchang Ko <suchangko@samul.kr>
[nicolas.ferre at atmel.com: split patch, reorder & whitespace fixes]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 9900abc5f00c..dcde334c1ff2 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -61,6 +61,8 @@
 		serial2 = &usart2;
 		serial3 = &usart0;
 		serial4 = &usart1;
+		serial5 = &uart0;
+		serial6 = &uart1;
 		gpio0 = &pioA;
 		gpio1 = &pioB;
 		gpio2 = &pioC;
@@ -849,6 +851,24 @@
 				clock-names = "mci_clk";
 			};
 
+			uart0: serial at f8004000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xf8004000 0x100>;
+				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(22))>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(23))>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart0>;
+				clocks = <&uart0_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
 			ssc0: ssc at f8008000 {
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf8008000 0x4000>;
@@ -1032,6 +1052,24 @@
 				clock-names = "mci_clk";
 			};
 
+			uart1: serial at fc004000 {
+				compatible = "atmel,at91sam9260-usart";
+				reg = <0xfc004000 0x100>;
+				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(24))>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(25))>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart1>;
+				clocks = <&uart1_clk>;
+				clock-names = "usart";
+				status = "disabled";
+			};
+
 			usart2: serial at fc008000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc008000 0x100>;
@@ -1661,6 +1699,24 @@
 					};
 				};
 
+				uart0 {
+					pinctrl_uart0: uart0-0 {
+						atmel,pins =
+							<AT91_PIOE 29 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
+							 AT91_PIOE 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							>;
+					};
+				};
+
+				uart1 {
+					pinctrl_uart1: uart1-0 {
+						atmel,pins =
+							<AT91_PIOC 25 AT91_PERIPH_C AT91_PINCTRL_NONE		/* RXD */
+							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* TXD */
+							>;
+					};
+				};
+
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-- 
2.1.3
