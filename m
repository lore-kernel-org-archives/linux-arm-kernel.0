From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 13:57:06 +0100
Subject: [PATCH 6/6] ARM: dts: imx6: add support for the Ka-Ro electronics
 'MB7' baseboard
In-Reply-To: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453294626-17608-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This baseboard can be used with all TX6 SoMs, but only a certain set
of combinations can be ordered. Add support for these combinations in
mainline, so that users can easily adopt their own combination of SoM
and baseboard themselves.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile                 |   2 +
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts | 236 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts  | 267 +++++++++++++++++++++++++++++
 3 files changed, 505 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e997d6c..d520c6d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -316,6 +316,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-tx6s-8035.dtb \
 	imx6dl-tx6u-8033.dtb \
 	imx6dl-tx6u-80xx.dtb \
+	imx6dl-tx6u-81xx-mb7.dtb \
 	imx6dl-tx6u-81xx.dtb \
 	imx6dl-udoo.dtb \
 	imx6dl-wandboard.dtb \
@@ -350,6 +351,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-tx6q-1036.dtb \
 	imx6q-tx6q-10x0-comtft.dtb \
 	imx6q-tx6q-10x0.dtb \
+	imx6q-tx6q-11x0-mb7.dtb \
 	imx6q-tx6q-11x0.dtb \
 	imx6q-udoo.dtb \
 	imx6q-wandboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
new file mode 100644
index 0000000..70552f6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
@@ -0,0 +1,236 @@
+/*
+ * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
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
+#include "imx6dl.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6U-81xx Module";
+	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
+
+	aliases {
+		display = &lvds0;
+		lvds0 = &lvds0;
+		lvds1 = &lvds1;
+	};
+
+	backlight0: backlight0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		power-supply = <&reg_3v3>;
+		/*
+		 * a poor man's way to create a 1:1 relationship between
+		 * the PWM value and the actual duty cycle
+		 */
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+	};
+
+	backlight1: backlight1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
+		power-supply = <&reg_3v3>;
+		/*
+		 * a poor man's way to create a 1:1 relationship between
+		 * the PWM value and the actual duty cycle
+		 */
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+	};
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&can2 {
+	xceiver-supply = <&reg_3v3>;
+};
+
+&i2c3 {
+	polytouch1: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 0>;
+		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&iomuxc {
+	imx6dl-tx6u-81xx {
+		pinctrl_eeti: eetigrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
+			>;
+		};
+	};
+};
+
+&kpp {
+	status = "disabled"; /* pads partially clash with backlight1 PWM */
+};
+
+&ldb {
+	status = "okay";
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds0_timing1>;
+
+			lvds0_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			lvds0_timing1: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vfront-porch = <12>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			lvds0_timing2: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <60>;
+				vsync-len = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+
+	lvds1: lvds-channel at 1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "disabled";
+
+		display-timings {
+			native-mode = <&lvds1_timing2>;
+
+			lvds1_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			lvds1_timing1: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vfront-porch = <12>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			lvds1_timing2: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <60>;
+				vsync-len = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&reg_lcd0_pwr {
+	status = "okay";
+};
+
+&reg_lcd1_pwr {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
new file mode 100644
index 0000000..d4c6a0e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
@@ -0,0 +1,267 @@
+/*
+ * Copyright 2014 Lothar Wa?mann <LW@KARO-electronics.de>
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
+#include "imx6q.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q-1110/-1130 Module";
+	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
+
+	aliases {
+		display = &lvds0;
+		ipu1 = &ipu2;
+		lvds0 = &lvds0;
+		lvds1 = &lvds1;
+		mxcfb0 = &lvds0;
+		mxcfb1 = &lvds1;
+	};
+
+	backlight0: backlight0 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		power-supply = <&reg_lcd0_pwr>;
+		/*
+		 * a poor man's way to create a 1:1 relationship between
+		 * the PWM value and the actual duty cycle
+		 */
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+	};
+
+	backlight1: backlight1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
+		power-supply = <&reg_lcd1_pwr>;
+		/*
+		 * a poor man's way to create a 1:1 relationship between
+		 * the PWM value and the actual duty cycle
+		 */
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <50>;
+	};
+
+	lvds0: fb at 0 {
+		compatible = "fsl,mxc_sdc_fb";
+		disp_dev = "ldb";
+		interface_pix_fmt = "RGB666";
+		mode_str = "LDB-VGA";
+		default_bpp = <32>;
+		int_clk = <0>;
+		late_init = <0>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds0_timing1>;
+
+			lvds0_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			lvds0_timing1: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vfront-porch = <12>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			lvds0_timing2: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <60>;
+				vsync-len = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+
+	lvds1: fb at 1 {
+		compatible = "fsl,mxc_sdc_fb";
+		disp_dev = "ldb";
+		interface_pix_fmt = "RGB24";
+		mode_str = "LDB-NL12880BC20";
+		default_bpp = <32>;
+		int_clk = <0>;
+		late_init = <0>;
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&lvds1_timing2>;
+
+			lvds1_timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			lvds1_timing1: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vfront-porch = <12>;
+				hsync-len = <96>;
+				vsync-len = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			lvds1_timing2: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vfront-porch = <5>;
+				hsync-len = <60>;
+				vsync-len = <13>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+	};
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&can2 {
+	xceiver-supply = <&reg_3v3>;
+};
+
+&i2c3 {
+	polytouch1: eeti at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eeti>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 0>;
+		wakeup-gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		linux,wakeup;
+	};
+};
+
+&iomuxc {
+	imx6q-tx6q-11x0 {
+		pinctrl_eeti: eetigrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b1 /* Interrupt */
+			>;
+		};
+	};
+};
+
+&ipu2 {
+	status = "disabled";
+};
+
+&kpp {
+	status = "disabled"; /* pads partially clash with backlight1 PWM */
+};
+
+&ldb {
+	ipu_id = <0>;
+	disp_id = <0>;
+	ext_ref = <0>;
+	mode = "sep0";
+	sec_ipu_id = <0>;
+	sec_disp_id = <1>;
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&reg_lcd0_pwr {
+	status = "okay";
+};
+
+&reg_lcd1_pwr {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
-- 
2.1.4
