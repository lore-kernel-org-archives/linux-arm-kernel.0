From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 17:13:03 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: add ISI dt support
Message-ID: <1425485583-16364-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Add ISI dt node and pinctrl settings in sama5d4.dtsi.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
[nicolas.ferre at atmel.com: sort nodes in order. remove useless comments]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 3041baaa19a1..63eb7a2c08f7 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -323,6 +323,21 @@
 				clock-names = "dma_clk";
 			};
 
+			isi: isi at f0008000 {
+				compatible = "atmel,at91sam9g45-isi";
+				reg = <0xf0008000 0x4000>;
+				interrupts = <52 IRQ_TYPE_LEVEL_HIGH 5>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_isi_data_0_7>;
+				clocks = <&isi_clk>;
+				clock-names = "isi_clk";
+				status = "disabled";
+				port {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+
 			ramc0: ramc at f0010000 {
 				compatible = "atmel,sama5d3-ddramc";
 				reg = <0xf0010000 0x200>;
@@ -1316,6 +1331,33 @@
 					};
 				};
 
+				isi {
+					pinctrl_isi_data_0_7: isi-0-data-0-7 {
+						atmel,pins =
+							<AT91_PIOC 19 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D0 */
+							 AT91_PIOC 20 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D1 */
+							 AT91_PIOC 21 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D2 */
+							 AT91_PIOC 22 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D3 */
+							 AT91_PIOC 23 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D4 */
+							 AT91_PIOC 24 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D5 */
+							 AT91_PIOC 25 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D6 */
+							 AT91_PIOC 26 AT91_PERIPH_A AT91_PINCTRL_NONE	/* ISI_D7 */
+							 AT91_PIOB  1 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_PCK, conflict with G0_RXCK */
+							 AT91_PIOB  3 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_VSYNC */
+							 AT91_PIOB  4 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* ISI_HSYNC */
+					};
+					pinctrl_isi_data_8_9: isi-0-data-8-9 {
+						atmel,pins =
+							<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_D8, conflicts with SPI0_MISO, PWMH2 */
+							 AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* ISI_D9, conflicts with SPI0_MOSI, PWML2 */
+					};
+					pinctrl_isi_data_10_11: isi-0-data-10-11 {
+						atmel,pins =
+							<AT91_PIOC 2 AT91_PERIPH_C AT91_PINCTRL_NONE	/* ISI_D10, conflicts with SPI0_SPCK, PWMH3 */
+							 AT91_PIOC 3 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* ISI_D11, conflicts with SPI0_NPCS0, PWML3 */
+					};
+				};
+
 				macb0 {
 					pinctrl_macb0_rmii: macb0_rmii-0 {
 						atmel,pins =
-- 
2.1.3
