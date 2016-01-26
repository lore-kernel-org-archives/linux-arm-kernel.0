From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Jan 2016 17:30:18 +0100
Subject: [PATCH] ARM: dts: at91: sama5d2: add dma properties to UART nodes
Message-ID: <1453825818-25217-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dmas/dma-names properties are added to the UART nodes. Note that additional
properties are needed to enable them at the board level: check bindings for
details.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 3f750f6170f2..82d0c19e9720 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -880,6 +880,13 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x100>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(35))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(36))>;
+				dma-names = "tx", "rx";
 				clocks = <&uart0_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -889,6 +896,13 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x100>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(37))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(38))>;
+				dma-names = "tx", "rx";
 				clocks = <&uart1_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -898,6 +912,13 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x100>;
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(39))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(40))>;
+				dma-names = "tx", "rx";
 				clocks = <&uart2_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -1016,6 +1037,13 @@
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc008000 0x100>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(41))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(42))>;
+				dma-names = "tx", "rx";
 				clocks = <&uart3_clk>;
 				clock-names = "usart";
 				status = "disabled";
@@ -1024,6 +1052,13 @@
 			uart4: serial at fc00c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc00c000 0x100>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(43))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(44))>;
+				dma-names = "tx", "rx";
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 7>;
 				clocks = <&uart4_clk>;
 				clock-names = "usart";
-- 
2.1.3
