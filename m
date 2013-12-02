From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 17:18:48 +0100
Subject: [PATCH] ARM: at91: add i2c2 pinctrl speficifation to sama5d3 DT
Message-ID: <1386001128-29147-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index f520b0236671..f5fd111b5ee6 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -304,6 +304,8 @@
 				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(11)>,
 				       <&dma1 2 AT91_DMA_CFG_PER_ID(12)>;
 				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c2>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&twi2_clk>;
@@ -494,6 +496,14 @@
 					};
 				};
 
+				i2c2 {
+					pinctrl_i2c2: i2c2-0 {
+						atmel,pins =
+							<AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_NONE	/* TWD2 pin, conflicts with LCDDAT18, ISI_D2 */
+							 AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* TWCK2 pin, conflicts with LCDDAT19, ISI_D3 */
+					};
+				};
+
 				isi {
 					pinctrl_isi: isi-0 {
 						atmel,pins =
-- 
1.8.2.2
