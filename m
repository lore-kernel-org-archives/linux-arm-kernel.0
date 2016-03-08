From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  8 Mar 2016 09:04:03 +0100
Subject: [PATCHv2 7/8] ARM: dts: imx6: add support for more Ka-Ro electronics
 modules
In-Reply-To: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1457424244-14549-8-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the following i.MX6 based modules from Ka-Ro
electronics GmbH:
TX6S-8034:
Processor    Freescale i.MX 6 Solo, 800MHz
RAM          256MiB DDR3 SDRAM
ROM          128MiB NAND Flash
Power supply Single 3.1V to 5.5V
Size         31mm SO-DIMM
Temp. Range  industrial grade (-40?C/-25?C to 105?C Tj)

TX6S-8035:
Processor    Freescale i.MX 6 Solo, 800MHz
RAM          512MiB DDR3 SDRAM
ROM          4GiB eMMC
Power supply Single 3.1V to 5.5V
Size         31mm SO-DIMM
Temp. Range  industrial grade (-40?C/-25?C to 105?C Tj)

TX6U-8033:
Processor    Freescale i.MX 6 Dual Lite, 800MHz
RAM          1GiB DDR3 SDRAM
ROM          4GiB eMMC
Power supply Single 3.1V to 5.5V
Size         31mm SO-DIMM
Temp. Range  industrial grade (-40?C/-25?C to 105?C Tj)

TX6Q-1036:
Processor    Freescale i.MX 6Quad, 1GHz
RAM          1GB DDR3 SDRAM 64-bit
ROM          8GiB eMMC
Power supply Single 3.1V to 5.5V
Size         31mm SO-DIMM
Temp. Range  Extended Consumer Grade (-20?C to 105?C Tj)

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/Makefile             |   4 +
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts | 249 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts | 246 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts | 248 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-tx6q-1036.dts  | 295 +++++++++++++++++++++++++++++++++
 5 files changed, 1042 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8034.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8035.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-8033.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1036.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 072294f..71b5cd3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -320,6 +320,9 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-tx6dl-comtft.dtb \
+	imx6dl-tx6s-8034.dtb \
+	imx6dl-tx6s-8035.dtb \
+	imx6dl-tx6u-8033.dtb \
 	imx6dl-tx6u-801x.dtb \
 	imx6dl-tx6u-811x.dtb \
 	imx6dl-udoo.dtb \
@@ -360,6 +363,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-tx6q-1010-comtft.dtb \
 	imx6q-tx6q-1020.dtb \
 	imx6q-tx6q-1020-comtft.dtb \
+	imx6q-tx6q-1036.dtb \
 	imx6q-tx6q-1110.dtb \
 	imx6q-udoo.dtb \
 	imx6q-wandboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
new file mode 100644
index 0000000..0d3df6e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
@@ -0,0 +1,237 @@
+/*
+ * Copyright 2015-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6S-8034 Module";
+	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
+
+	aliases {
+		display = &display;
+		ipu1 = &ipu1;
+	};
+
+	cpus {
+		/delete-node/ cpu at 1;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_pwr>;
+		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
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
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_2>;
+		interface-pix-fmt = "rgb24";
+		status = "okay";
+
+		port {
+			display0_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		display-timings {
+			native-mode = <&vga>;
+
+			vga: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vsync-len = <2>;
+				vfront-porch = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETV570 {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <114>;
+				hsync-len = <30>;
+				hfront-porch = <16>;
+				vback-porch = <32>;
+				vsync-len = <3>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0350 {
+				clock-frequency = <6413760>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <34>;
+				hsync-len = <34>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0430 {
+				clock-frequency = <9009000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vsync-len = <10>;
+				vfront-porch = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			ET0500 {
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0700 { /* same as ET0500 */
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETQ570 {
+				clock-frequency = <6596040>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <38>;
+				hsync-len = <30>;
+				hfront-porch = <30>;
+				vback-porch = <16>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&pinctrl_usdhc1 {
+	fsl,pins = <
+		MX6QDL_PAD_SD1_CMD__SD1_CMD		0x070b1
+		MX6QDL_PAD_SD1_CLK__SD1_CLK		0x07099
+		MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x070b1
+		MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x070b1
+		MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x070b1
+		MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x070b1
+		MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x170b0 /* SD1 CD */
+	>;
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&reg_lcd0_pwr {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
new file mode 100644
index 0000000..2f9efdb
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
@@ -0,0 +1,253 @@
+/*
+ * Copyright 2015-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6S-8035 Module";
+	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
+
+	aliases {
+		display = &display;
+		ipu1 = &ipu1;
+	};
+
+	cpus {
+		/delete-node/ cpu at 1;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_pwr>;
+		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
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
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_2>;
+		interface-pix-fmt = "rgb24";
+		status = "okay";
+
+		port {
+			display0_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		display-timings {
+			native-mode = <&vga>;
+
+			vga: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vsync-len = <2>;
+				vfront-porch = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETV570 {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <114>;
+				hsync-len = <30>;
+				hfront-porch = <16>;
+				vback-porch = <32>;
+				vsync-len = <3>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0350 {
+				clock-frequency = <6413760>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <34>;
+				hsync-len = <34>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0430 {
+				clock-frequency = <9009000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vsync-len = <10>;
+				vfront-porch = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			ET0500 {
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0700 { /* same as ET0500 */
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETQ570 {
+				clock-frequency = <6596040>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <38>;
+				hsync-len = <30>;
+				hfront-porch = <30>;
+				vback-porch = <16>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&reg_lcd0_pwr {
+	status = "disabled";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <4>;
+	non-removable;
+	no-1-8-v;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
new file mode 100644
index 0000000..4d3204a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
@@ -0,0 +1,248 @@
+/*
+ * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6U-8033 Module";
+	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
+
+	aliases {
+		display = &display;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_pwr>;
+		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
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
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_2>;
+		interface-pix-fmt = "rgb24";
+		status = "okay";
+
+		port {
+			display0_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		display-timings {
+			native-mode = <&vga>;
+
+			vga: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vsync-len = <2>;
+				vfront-porch = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETV570 {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <114>;
+				hsync-len = <30>;
+				hfront-porch = <16>;
+				vback-porch = <32>;
+				vsync-len = <3>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0350 {
+				clock-frequency = <6413760>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <34>;
+				hsync-len = <34>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0430 {
+				clock-frequency = <9009000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vsync-len = <10>;
+				vfront-porch = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			ET0500 {
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0700 { /* same as ET0500 */
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETQ570 {
+				clock-frequency = <6596040>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <38>;
+				hsync-len = <30>;
+				hfront-porch = <30>;
+				vback-porch = <16>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&reg_lcd0_pwr {
+	status = "disabled";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <4>;
+	non-removable;
+	no-1-8-v;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036.dts b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
new file mode 100644
index 0000000..70c478b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
@@ -0,0 +1,252 @@
+/*
+ * Copyright 2014-2016 Lothar Wa?mann <LW@KARO-electronics.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-tx6.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX6Q-1036 Module";
+	compatible = "karo,imx6q-tx6q", "fsl,imx6q";
+
+	aliases {
+		display = &display;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 500000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_lcd0_pwr>;
+		enable-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
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
+	display: display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_disp0_2>;
+		interface-pix-fmt = "rgb24";
+		status = "okay";
+
+		port {
+			display0_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		display-timings {
+			native-mode = <&vga>;
+
+			vga: VGA {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <48>;
+				hsync-len = <96>;
+				hfront-porch = <16>;
+				vback-porch = <31>;
+				vsync-len = <2>;
+				vfront-porch = <12>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETV570 {
+				clock-frequency = <25200000>;
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <114>;
+				hsync-len = <30>;
+				hfront-porch = <16>;
+				vback-porch = <32>;
+				vsync-len = <3>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0350 {
+				clock-frequency = <6413760>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <34>;
+				hsync-len = <34>;
+				hfront-porch = <20>;
+				vback-porch = <15>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0430 {
+				clock-frequency = <9009000>;
+				hactive = <480>;
+				vactive = <272>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				hfront-porch = <2>;
+				vback-porch = <2>;
+				vsync-len = <10>;
+				vfront-porch = <2>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+
+			ET0500 {
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ET0700 { /* same as ET0500 */
+				clock-frequency = <33264000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <88>;
+				hsync-len = <128>;
+				hfront-porch = <40>;
+				vback-porch = <33>;
+				vsync-len = <2>;
+				vfront-porch = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+
+			ETQ570 {
+				clock-frequency = <6596040>;
+				hactive = <320>;
+				vactive = <240>;
+				hback-porch = <38>;
+				hsync-len = <30>;
+				hfront-porch = <30>;
+				vback-porch = <16>;
+				vsync-len = <3>;
+				vfront-porch = <4>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&ds1339 {
+	status = "disabled";
+};
+
+&gpmi {
+	status = "disabled";
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
+&ipu2 {
+	status = "disabled";
+};
+
+&reg_lcd0_pwr {
+	status = "disabled";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <4>;
+	non-removable;
+	no-1-8-v;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x070b1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x070b1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x070b1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x070b1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x070b1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x070b1
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x0b0b1
+		>;
+	};
+};
-- 
2.1.4
