From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Dec 2013 13:42:08 +0100
Subject: [PATCH] ARM: dts: imx53: add support for Ka-Ro TX53 modules
Message-ID: <1386852128-32220-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the Ka-Ro electronics GmbH TX53 modules.
There are two distinct module types. One with an LVDS display
interface and SATA support, the other with a parallel LCD
interface and no SATA interface.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile            |    2 +
 arch/arm/boot/dts/imx53-tx53-x03x.dts |  269 ++++++++++++
 arch/arm/boot/dts/imx53-tx53-x13x.dts |  283 ++++++++++++
 arch/arm/boot/dts/imx53-tx53.dtsi     |  420 ++++++++++++++++--
 5 files changed, 1701 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx53-tx53-x03x.dts
 create mode 100644 arch/arm/boot/dts/imx53-tx53-x13x.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 741bf73..51aa137 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -140,6 +140,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx53-tx53-x03x.dtb \
+	imx53-tx53-x13x.dtb \
 	imx53-voipac-bsb.dtb \
 	imx6dl-gw51xx.dtb \
 	imx6dl-gw52xx.dtb \
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
new file mode 100644
index 0000000..26853fe
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -0,0 +1,269 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx53-tx53.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX53 module";
+	compatible = "karo,tx53", "fsl,imx53";
+
+	aliases {
+		display = &display;
+	};
+
+	soc {
+		display: display at di0 {
+			compatible = "fsl,imx-parallel-display";
+			crtcs = <&ipu 0>;
+			interface-pix-fmt = "rgb24";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_rgb24_vga_1>;
+			status = "okay";
+
+			display-timings {
+				VGA {
+					clock-frequency = <25200000>;
+					hactive = <640>;
+					vactive = <480>;
+					hback-porch = <48>;
+					hsync-len = <96>;
+					hfront-porch = <16>;
+					vback-porch = <31>;
+					vsync-len = <2>;
+					vfront-porch = <12>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <0>;
+				};
+
+				ETV570 {
+					clock-frequency = <25200000>;
+					hactive = <640>;
+					vactive = <480>;
+					hback-porch = <114>;
+					hsync-len = <30>;
+					hfront-porch = <16>;
+					vback-porch = <32>;
+					vsync-len = <3>;
+					vfront-porch = <10>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <0>;
+				};
+
+				ET0350 {
+					clock-frequency = <6413760>;
+					hactive = <320>;
+					vactive = <240>;
+					hback-porch = <34>;
+					hsync-len = <34>;
+					hfront-porch = <20>;
+					vback-porch = <15>;
+					vsync-len = <3>;
+					vfront-porch = <4>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <0>;
+				};
+
+				ET0430 {
+					clock-frequency = <9009000>;
+					hactive = <480>;
+					vactive = <272>;
+					hback-porch = <2>;
+					hsync-len = <41>;
+					hfront-porch = <2>;
+					vback-porch = <2>;
+					vsync-len = <10>;
+					vfront-porch = <2>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <1>;
+				};
+
+				ET0500 {
+					clock-frequency = <33264000>;
+					hactive = <800>;
+					vactive = <480>;
+					hback-porch = <88>;
+					hsync-len = <128>;
+					hfront-porch = <40>;
+					vback-porch = <33>;
+					vsync-len = <2>;
+					vfront-porch = <10>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <0>;
+				};
+
+				ET0700 { /* same as ET0500 */
+					clock-frequency = <33264000>;
+					hactive = <800>;
+					vactive = <480>;
+					hback-porch = <88>;
+					hsync-len = <128>;
+					hfront-porch = <40>;
+					vback-porch = <33>;
+					vsync-len = <2>;
+					vfront-porch = <10>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <0>;
+				};
+
+				ETQ570 {
+					clock-frequency = <6596040>;
+					hactive = <320>;
+					vactive = <240>;
+					hback-porch = <38>;
+					hsync-len = <30>;
+					hfront-porch = <30>;
+					vback-porch = <16>;
+					vsync-len = <3>;
+					vfront-porch = <4>;
+					hsync-active = <0>;
+					vsync-active = <0>;
+					de-active = <1>;
+					pixelclk-active = <0>;
+				};
+			};
+		};
+	};
+
+	backlight0: pwm-backlight at 0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			100 99 98 97 96 95 94 93 92 91
+			 90 89 88 87 86 85 84 83 82 81
+			 80 79 78 77 76 75 74 73 72 71
+			 70 69 68 67 66 65 64 63 62 61
+			 60 59 58 57 56 55 54 53 52 51
+			 50 49 48 47 46 45 44 43 42 41
+			 40 39 38 37 36 35 34 33 32 31
+			 30 29 28 27 26 25 24 23 22 21
+			 20 19 18 17 16 15 14 13 12 11
+			 10  9  8  7  6  5  4  3  2  1
+			  0
+		>;
+		default-brightness-level = <50>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_lcd_pwr: regulator at 5 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS0 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		reg_lcd_reset: regulator at 6 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS1 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_2v5>;
+		VDDIO-supply = <&reg_3v3>;
+		clocks = <&mclk>;
+	};
+
+	touchscreen: tsc2007 at 48 {
+		compatible = "ti,tsc2007";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 0>;
+		gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
+		ti,x-plate-ohms = <660>;
+		linux,wakeup;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	kpp {
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX53_PAD_GPIO_9__KPP_COL_6 0x80000000
+				MX53_PAD_GPIO_4__KPP_COL_7 0x80000000
+				MX53_PAD_KEY_COL2__KPP_COL_2 0x80000000
+				MX53_PAD_KEY_COL3__KPP_COL_3 0x80000000
+
+				MX53_PAD_GPIO_2__KPP_ROW_6 0x80000000
+				MX53_PAD_GPIO_5__KPP_ROW_7 0x80000000
+				MX53_PAD_KEY_ROW2__KPP_ROW_2 0x80000000
+				MX53_PAD_KEY_ROW3__KPP_ROW_3 0x80000000
+			>;
+		};
+	};
+
+	touchpanel {
+		pinctrl_tsc2007: tsc2007grp-1 {
+			fsl,pins = <
+				MX53_PAD_EIM_D26__GPIO3_26 0xe0 /* Interrupt */
+			>;
+		};
+	};
+};
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	status = "okay";
+
+	/* sample keymap */
+	/* row/col 0,1 are mapped to KPP row/col 6,7 */
+	linux,keymap = <
+		0x06060074 /* row 6, col 6, KEY_POWER */
+		0x06070052 /* row 6, col 7, KEY_KP0 */
+		0x0602004f /* row 6, col 2, KEY_KP1 */
+		0x06030050 /* row 6, col 3, KEY_KP2 */
+		0x07060051 /* row 7, col 6, KEY_KP3 */
+		0x0707004b /* row 7, col 7, KEY_KP4 */
+		0x0702004c /* row 7, col 2, KEY_KP5 */
+		0x0703004d /* row 7, col 3, KEY_KP6 */
+		0x02060047 /* row 2, col 6, KEY_KP7 */
+		0x02070048 /* row 2, col 7, KEY_KP8 */
+		0x02020049 /* row 2, col 2, KEY_KP9 */
+	>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
new file mode 100644
index 0000000..a5e08e0
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -0,0 +1,283 @@
+/*
+ * Copyright 2013 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx53-tx53.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX53 module (LVDS)";
+	compatible = "karo,tx53", "fsl,imx53";
+
+	aliases {
+		display = &lvds0;
+		lvds0 = &lvds0;
+		lvds1 = &lvds1;
+	};
+
+	backlight0: pwm-backlight at 0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			  0  1  2  3  4  5  6  7  8  9
+			 10 11 12 13 14 15 16 17 18 19
+			 20 21 22 23 24 25 26 27 28 29
+			 30 31 32 33 34 35 36 37 38 39
+			 40 41 42 43 44 45 46 47 48 49
+			 50 51 52 53 54 55 56 57 58 59
+			 60 61 62 63 64 65 66 67 68 69
+			 70 71 72 73 74 75 76 77 78 79
+			 80 81 82 83 84 85 86 87 88 89
+			 90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <50>;
+	};
+
+	backlight1: pwm-backlight at 1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000>;
+		power-supply = <&reg_3v3>;
+		brightness-levels = <
+			  0  1  2  3  4  5  6  7  8  9
+			 10 11 12 13 14 15 16 17 18 19
+			 20 21 22 23 24 25 26 27 28 29
+			 30 31 32 33 34 35 36 37 38 39
+			 40 41 42 43 44 45 46 47 48 49
+			 50 51 52 53 54 55 56 57 58 59
+			 60 61 62 63 64 65 66 67 68 69
+			 70 71 72 73 74 75 76 77 78 79
+			 80 81 82 83 84 85 86 87 88 89
+			 90 91 92 93 94 95 96 97 98 99
+			100
+		>;
+		default-brightness-level = <50>;
+	};
+
+	regulators {
+		reg_lcd_pwr0: regulator at 5 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS0 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
+		reg_lcd_pwr1: regulator at 6 {
+			compatible = "regulator-fixed";
+			regulator-name = "LVDS1 POWER";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	touchscreen2: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti_2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <23 0>;
+		wakeup-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		VDDA-supply = <&reg_2v5>;
+		VDDIO-supply = <&reg_3v3>;
+		clocks = <&mclk>;
+	};
+
+	touchscreen1: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti_1>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 0>;
+		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	i2c {
+		pinctrl_i2c2: i2c2-grp1 {
+			fsl,pins = <MX53_I2C2_PINGRP1>;
+		};
+	};
+
+	kpp {
+		pinctrl_kpp: kppgrp {
+			fsl,pins = <
+				MX53_PAD_GPIO_9__KPP_COL_6 0x80000000
+				MX53_PAD_GPIO_4__KPP_COL_7 0x80000000
+				MX53_PAD_KEY_COL2__KPP_COL_2 0x80000000
+
+				MX53_PAD_GPIO_2__KPP_ROW_6 0x80000000
+				MX53_PAD_GPIO_5__KPP_ROW_7 0x80000000
+				MX53_PAD_KEY_ROW2__KPP_ROW_2 0x80000000
+			>;
+		};
+	};
+
+	lvds {
+		pinctrl_lvds0: lvds0grp {
+			fsl,pins = <
+				MX53_PAD_LVDS0_TX3_P__LDB_LVDS0_TX3 0x80000000
+				MX53_PAD_LVDS0_CLK_P__LDB_LVDS0_CLK 0x80000000
+				MX53_PAD_LVDS0_TX2_P__LDB_LVDS0_TX2 0x80000000
+				MX53_PAD_LVDS0_TX1_P__LDB_LVDS0_TX1 0x80000000
+				MX53_PAD_LVDS0_TX0_P__LDB_LVDS0_TX0 0x80000000
+			>;
+		};
+
+		pinctrl_lvds1: lvds1grp {
+			fsl,pins = <
+				MX53_PAD_LVDS1_TX3_P__LDB_LVDS1_TX3 0x80000000
+				MX53_PAD_LVDS1_TX2_P__LDB_LVDS1_TX2 0x80000000
+				MX53_PAD_LVDS1_CLK_P__LDB_LVDS1_CLK 0x80000000
+				MX53_PAD_LVDS1_TX1_P__LDB_LVDS1_TX1 0x80000000
+				MX53_PAD_LVDS1_TX0_P__LDB_LVDS1_TX0 0x80000000
+			>;
+		};
+	};
+
+	pwm {
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <MX53_PAD_GPIO_9__PWM1_PWMO 0x80000000>;
+		};
+	};
+
+	touchpanel {
+		pinctrl_eeti_1: eetigrp-1 {
+			fsl,pins = <
+				MX53_PAD_EIM_D22__GPIO3_22 0xe0 /* Interrupt */
+			>;
+		};
+
+		pinctrl_eeti_2: eetigrp-2 {
+			fsl,pins = <
+				MX53_PAD_EIM_D23__GPIO3_23 0xe0 /* Interrupt */
+			>;
+		};
+	};
+};
+
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	status = "okay";
+
+	/* sample keymap */
+	/* row/col 0,1 are mapped to KPP row/col 6,7
+	 * row/col 3 are used for I2C2 (second touch controller on hsd100pxn1)
+	 */
+	linux,keymap = <
+		0x06060074 /* row 6, col 6, KEY_POWER */
+		0x06070052 /* row 6, col 7, KEY_KP0 */
+		0x0602004f /* row 6, col 2, KEY_KP1 */
+		0x07060050 /* row 7, col 6, KEY_KP2 */
+		0x07070051 /* row 7, col 7, KEY_KP3 */
+		0x0702004b /* row 7, col 2, KEY_KP4 */
+		0x0206004c /* row 2, col 6, KEY_KP5 */
+		0x0207004d /* row 2, col 7, KEY_KP6 */
+		0x02020047 /* row 2, col 2, KEY_KP7 */
+	>;
+};
+
+&ldb {
+	status = "okay";
+//	fsl,dual-channel;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds0 &pinctrl_lvds1>;
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "jeida";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds_timing0>;
+			lvds_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+				vfront-porch = <7>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-mapping = "jeida";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds_timing1>;
+			lvds_timing1: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hsync-len = <60>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vsync-len = <10>;
+				vfront-porch = <7>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index db4255c..63bfa97 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -1,125 +1,455 @@
 /*
- * Copyright 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ * Copyright 2012 <LW@KARO-electronics.de>
+ * based on imx53-qsb.dts
+ *   Copyright 2011 Freescale Semiconductor, Inc.
+ *   Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
+ * Version 2 at the following locations:
  *
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-/include/ "imx53.dtsi"
+#include "imx53.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Ka-Ro TX53";
+	model = "Ka-Ro electronics TX53 module";
 	compatible = "karo,tx53", "fsl,imx53";
 
-	memory {
-		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
+	aliases {
+		can0 = &can1;
+		can1 = &can2;
+		ipu = &ipu;
+		reg_can_xcvr = &reg_can_xcvr;
+		usbh1 = &usbh1;
+		usbotg = &usbotg;
+	};
+
+	clocks {
+		ckih1 {
+			clock-frequency = <0>;
+		};
+
+		mclk: codec_clock {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <27000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_stk5led>;
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
 	};
 
 	regulators {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		reg_3p3v: regulator at 0 {
+		reg_2v5: regulator at 0 {
 			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "3P3V";
+			regulator-name = "2V5";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+
+		reg_3v3: regulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		reg_can_xcvr: regulator at 2 {
+			compatible = "regulator-fixed";
+			regulator-name = "CAN XCVR";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
+			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+			enable-active-low;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_can_xcvr>;
+		};
+
+		reg_usbh1_vbus: regulator at 3 {
+			compatible = "regulator-fixed";
+			regulator-name = "usbh1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_usbotg_vbus: regulator at 4 {
+			compatible = "regulator-fixed";
+			regulator-name = "usbotg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
 		};
 	};
+
+	sound {
+		compatible = "karo,tx53-audio-sgtl5000", "fsl,imx-audio-sgtl5000";
+		model = "tx53-audio-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		/* '1' based port numbers according to datasheet names */
+		mux-int-port = <1>;
+		mux-ext-port = <5>;
+	};
+};
+
+&audmux {
+	status = "okay";
 };
 
 &can1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_can1_2>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_can_xcvr>;
+
+	status = "okay";
 };
 
 &can2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_can2_1>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_can2>;
+	xceiver-supply = <&reg_can_xcvr>;
+
+	status = "okay";
 };
 
 &ecspi1 {
+	status = "okay";
+
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1_2>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <
+		&gpio2 30 GPIO_ACTIVE_HIGH
+		&gpio3 19 GPIO_ACTIVE_HIGH
+	>;
+
+	spidev0: spi at 0 {
+		compatible = "spidev";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
 };
 
 &esdhc1 {
+	status = "okay";
+	cd-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
+	fsl,wp-controller;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1_2>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_esdhc1>;
 };
 
 &esdhc2 {
+	status = "okay";
+	cd-gpios = <&gpio3 25 GPIO_ACTIVE_HIGH>;
+	fsl,wp-controller;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc2_1>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_esdhc2>;
 };
 
 &fec {
+	status = "okay";
+
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec_1>;
+	pinctrl-0 = <&pinctrl_fec>;
+
 	phy-mode = "rmii";
-	status = "disabled";
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-handle = <&phy0>;
+	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
+
+	phy0: ethernet-phy at 0 {
+		interrupt-parent = <&gpio2>;
+		interrupts = <4>;
+		device_type = "ethernet-phy";
+	};
 };
 
-&i2c3 {
+&i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3_2>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	rtc1: ds1339 at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ds1339>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <20 0>;
+	};
+
+	pmic: lt3589 at 48 {
+		compatible = "lt,lt3589";
+		reg = <0x48>;
+	};
 };
 
-&owire {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_owire_1>;
-	status = "disabled";
+&iomuxc {
+	display {
+		pinctrl_rgb24_vga_1: rgb24-vga-grp-1 {
+			fsl,pins = <
+				MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0 0x80000000
+				MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1 0x80000000
+				MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2 0x80000000
+				MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3 0x80000000
+				MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4 0x80000000
+				MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5 0x80000000
+				MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6 0x80000000
+				MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7 0x80000000
+				MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8 0x80000000
+				MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9 0x80000000
+				MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10 0x80000000
+				MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11 0x80000000
+				MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12 0x80000000
+				MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13 0x80000000
+				MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14 0x80000000
+				MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15 0x80000000
+				MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16 0x80000000
+				MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17 0x80000000
+				MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18 0x80000000
+				MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19 0x80000000
+				MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20 0x80000000
+				MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21 0x80000000
+				MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22 0x80000000
+				MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23 0x80000000
+				MX53_PAD_DI0_PIN2__IPU_DI0_PIN2 0x80000000 /* HSYNC */
+				MX53_PAD_DI0_PIN3__IPU_DI0_PIN3 0x80000000 /* VSYNC */
+				MX53_PAD_DI0_PIN15__IPU_DI0_PIN15 0x80000000 /* OE */
+				MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK 0x80000000 /* PIXCLK */
+			>;
+		};
+
+		pinctrl_rgb24_vga_2: rgb24-vga-grp-2 {
+			fsl,pins = <
+				MX53_PAD_EIM_DA0__IPU_DISP1_DAT_9 0x80000000
+				MX53_PAD_EIM_DA1__IPU_DISP1_DAT_8 0x80000000
+				MX53_PAD_EIM_DA2__IPU_DISP1_DAT_7 0x80000000
+				MX53_PAD_EIM_DA3__IPU_DISP1_DAT_6 0x80000000
+				MX53_PAD_EIM_DA4__IPU_DISP1_DAT_5 0x80000000
+				MX53_PAD_EIM_DA5__IPU_DISP1_DAT_4 0x80000000
+				MX53_PAD_EIM_DA6__IPU_DISP1_DAT_3 0x80000000
+				MX53_PAD_EIM_DA7__IPU_DISP1_DAT_2 0x80000000
+				MX53_PAD_EIM_DA8__IPU_DISP1_DAT_1 0x80000000
+				MX53_PAD_EIM_DA9__IPU_DISP1_DAT_0 0x80000000
+			>;
+		};
+	};
+
+	ds1339 {
+		pinctrl_ds1339: ds1339grp {
+			fsl,pins = <MX53_PAD_DI0_PIN4__GPIO4_20 0xe0>;
+		};
+	};
+
+	ecspi {
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <MX53_ECSPI1_PINGRP2>;
+		};
+	};
+
+	esdhc {
+		pinctrl_esdhc1: esdhc1grp {
+			fsl,pins = <MX53_ESDHC1_PINGRP1
+				MX53_PAD_EIM_D24__GPIO3_24 0x1f0
+			>;
+		};
+
+		pinctrl_esdhc2: esdhc2grp {
+			fsl,pins = <MX53_ESDHC2_PINGRP1
+				MX53_PAD_EIM_D25__GPIO3_25 0x1f0
+			>;
+		};
+	};
+
+	fec {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <MX53_FEC_PINGRP1>;
+		};
+	};
+
+	flexcan {
+		pinctrl_can1: can1grp {
+			fsl,pins = <MX53_CAN1_PINGRP3>;
+		};
+
+		pinctrl_can2: can2grp {
+			fsl,pins = <MX53_CAN1_PINGRP3>;
+		};
+
+		pinctrl_can_xcvr: can-xcvrgrp {
+			fsl,pins = <MX53_PAD_DISP0_DAT0__GPIO4_21 0xe0>; /* Flexcan XCVR enable */
+		};
+	};
+
+	i2c {
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX53_I2C1_PINGRP2>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <MX53_I2C3_PINGRP2>;
+		};
+	};
+
+	leds {
+		pinctrl_stk5led: stk5ledgrp {
+			fsl,pins = <MX53_PAD_EIM_A18__GPIO2_20 0xc0>;
+		};
+	};
+
+	pwm {
+		pinctrl_pwm2: pwm2grp {
+			fsl,pins = <MX53_PWM2_PINGRP1>;
+		};
+	};
+
+	ssi {
+		pinctrl_ssi1: ssi1grp {
+			fsl,pins = <MX53_AUDMUX_PINGRP1
+				MX53_PAD_EIM_D26__GPIO3_26 0x1f0
+			>;
+		};
+
+		pinctrl_ssi2: ssi2grp {
+			fsl,pins = <MX53_AUDMUX_PINGRP3
+				MX53_PAD_EIM_D27__GPIO3_27 0x1f0
+			>;
+		};
+	};
+
+	uart {
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX53_UART1_PINGRP2 MX53_UART1_PINGRP3>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <MX53_UART2_PINGRP2>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <MX53_UART3_PINGRP1>;
+		};
+	};
+
+	usbh1 {
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX53_PAD_EIM_D31__GPIO3_31 0xe0 /* VBUS ENABLE */
+				MX53_PAD_EIM_D30__GPIO3_30 0x100 /* OC */
+			>;
+		};
+	};
+
+	usbotg {
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX53_PAD_GPIO_7__GPIO1_7 0xe0 /* VBUS ENABLE */
+				MX53_PAD_GPIO_8__GPIO1_8 0x100 /* OC */
+			>;
+		};
+	};
+};
+
+&ipu {
+	status = "okay";
+};
+
+&nfc {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
 };
 
 &pwm2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm2_1>;
-	status = "disabled";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
+&sdma {
+	fsl,sdma-ram-script-name = "sdma-imx53.bin";
 };
 
 &ssi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux_1>;
-	status = "disabled";
+	fsl,mode = "i2s-slave";
+	codec-handle = <&sgtl5000>;
+	status = "okay";
 };
 
 &ssi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux_2>;
 	status = "disabled";
 };
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1_2>,
-		    <&pinctrl_uart1_3>;
+	pinctrl-0 = <&pinctrl_uart1>;
 	fsl,uart-has-rtscts;
-	status = "disabled";
+	status = "okay";
 };
 
 &uart2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2_2>;
+	pinctrl-0 = <&pinctrl_uart2>;
 	fsl,uart-has-rtscts;
-	status = "disabled";
+	status = "okay";
 };
 
 &uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3_1>;
+	pinctrl-0 = <&pinctrl_uart3>;
 	fsl,uart-has-rtscts;
-	status = "disabled";
+	status = "okay";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	disable-over-current;
+	vbus-supply = <&reg_usbh1_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	vbus-supply = <&reg_usbotg_vbus>;
+	status = "okay";
 };
-- 
1.7.2.5
