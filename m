From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 12:04:36 -0200
Subject: [PATCH 3/5] ARM: dts: imx28-tx28: Pass unit address and reg to IOMUX
 node
In-Reply-To: <1514383478-32544-1-git-send-email-festevam@gmail.com>
References: <1514383478-32544-1-git-send-email-festevam@gmail.com>
Message-ID: <1514383478-32544-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass unit address and reg to IOMUX node to fix the following build
warning with W=1:

arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-edt-ft5x06-pins missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-flexcan-xcvr-pins missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-lcdif-23bit missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-lcdif-ctrl missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-mac0-gpio-pins missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-pca9554-pins missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/spi-gpiogrp missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-tsc2007-pins missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-usbphy0-pins missing or empty reg/ranges property
arch/arm/boot/dts/imx28-tx28.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbh at 80000000/pinctrl at 80018000/tx28-usbphy1-pins missing or empty reg/ranges property

Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-tx28.dts | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 152621e..8a4f5bc 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -531,7 +531,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_edt_ft5x06_pins: tx28-edt-ft5x06-pins {
+	tx28_edt_ft5x06_pins: tx28-edt-ft5x06-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_SSP0_DATA6__GPIO_2_6 /* RESET */
 			MX28_PAD_SSP0_DATA5__GPIO_2_5 /* IRQ */
@@ -542,7 +543,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_flexcan_xcvr_pins: tx28-flexcan-xcvr-pins {
+	tx28_flexcan_xcvr_pins: tx28-flexcan-xcvr-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_D00__GPIO_1_0
 		>;
@@ -551,7 +553,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_lcdif_23bit_pins: tx28-lcdif-23bit {
+	tx28_lcdif_23bit_pins: tx28-lcdif-23bit at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			/* LCD_D00 may be used as Flexcan Transceiver Enable on STK5-V5 */
 			MX28_PAD_LCD_D01__LCD_D1
@@ -583,7 +586,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_lcdif_ctrl_pins: tx28-lcdif-ctrl {
+	tx28_lcdif_ctrl_pins: tx28-lcdif-ctrl at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_LCD_ENABLE__GPIO_1_31 /* Enable */
 			MX28_PAD_LCD_RESET__GPIO_3_30  /* Reset */
@@ -593,7 +597,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_mac0_pins_gpio: tx28-mac0-gpio-pins {
+	tx28_mac0_pins_gpio: tx28-mac0-gpio-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_ENET0_MDC__GPIO_4_0
 			MX28_PAD_ENET0_MDIO__GPIO_4_1
@@ -610,7 +615,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_pca9554_pins: tx28-pca9554-pins {
+	tx28_pca9554_pins: tx28-pca9554-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_PWM3__GPIO_3_28
 		>;
@@ -619,7 +625,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_spi_gpio_pins: spi-gpiogrp {
+	tx28_spi_gpio_pins: spi-gpiogrp at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_AUART2_RX__GPIO_3_8
 			MX28_PAD_AUART2_TX__GPIO_3_9
@@ -633,7 +640,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_tsc2007_pins: tx28-tsc2007-pins {
+	tx28_tsc2007_pins: tx28-tsc2007-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_SAIF0_MCLK__GPIO_3_20 /* TSC2007 IRQ */
 		>;
@@ -643,7 +651,8 @@
 	};
 
 
-	tx28_usbphy0_pins: tx28-usbphy0-pins {
+	tx28_usbphy0_pins: tx28-usbphy0-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_GPMI_CE2N__GPIO_0_18 /* USBOTG_VBUSEN */
 			MX28_PAD_GPMI_CE3N__GPIO_0_19 /* USBOTH_OC */
@@ -653,7 +662,8 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
-	tx28_usbphy1_pins: tx28-usbphy1-pins {
+	tx28_usbphy1_pins: tx28-usbphy1-pins at 0 {
+		reg = <0>;
 		fsl,pinmux-ids = <
 			MX28_PAD_SPDIF__GPIO_3_27 /* USBH_VBUSEN */
 			MX28_PAD_JTAG_RTCK__GPIO_4_20 /* USBH_OC */
-- 
2.7.4
