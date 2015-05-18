From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 18 May 2015 11:50:04 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4: add spi1, spi2 dt nodes
Message-ID: <1431942604-28622-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suchang Ko <suchangko@samul.kr>

Signed-off-by: Suchang Ko <suchangko@samul.kr>
[nicolas.ferre at atmel.com: split patch, reorder & whitespace fixes]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index dcde334c1ff2..cb312c942807 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1142,6 +1142,46 @@
 				status = "disabled";
 			};
 
+			spi1: spi at fc018000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfc018000 0x100>;
+				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(12))>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(13))>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi1>;
+				clocks = <&spi1_clk>;
+				clock-names = "spi_clk";
+				status = "disabled";
+			};
+
+			spi2: spi at fc01c000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "atmel,at91rm9200-spi";
+				reg = <0xfc01c000 0x100>;
+				interrupts = <39 IRQ_TYPE_LEVEL_HIGH 3>;
+				dmas = <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(14))>,
+				       <&dma1
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+					| AT91_XDMAC_DT_PERID(15))>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_spi2>;
+				clocks = <&spi2_clk>;
+				clock-names = "spi_clk";
+				status = "disabled";
+			};
+
 			tcb1: timer at fc020000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xfc020000 0x100>;
@@ -1699,6 +1739,26 @@
 					};
 				};
 
+				spi1 {
+					pinctrl_spi1: spi1-0 {
+						atmel,pins =
+							<AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_NONE	/* SPI1_MISO */
+							 AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE	/* SPI1_MOSI */
+							 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE	/* SPI1_SPCK */
+							>;
+					};
+				};
+
+				spi2 {
+					pinctrl_spi2: spi2-0 {
+						atmel,pins =
+							<AT91_PIOD 11 AT91_PERIPH_B AT91_PINCTRL_NONE	/* SPI2_MISO conflicts with RTS0 */
+							 AT91_PIOD 13 AT91_PERIPH_B AT91_PINCTRL_NONE	/* SPI2_MOSI conflicts with TXD0 */
+							 AT91_PIOD 15 AT91_PERIPH_B AT91_PINCTRL_NONE	/* SPI2_SPCK conflicts with RTS1 */
+							>;
+					};
+				};
+
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-- 
2.1.3
