From: dev@lynxeye.de (Lucas Stach)
Date: Sun,  8 Jan 2017 14:58:30 +0100
Subject: [PATCH] ARM: imx6: add support for SolidRun Hummingboard2
Message-ID: <20170108135830.22595-1-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aka: Hummingboard Edge and Hummingboard Gate

This currently only supports the pieces I was able to test:
- RTC
- SD card with UHS modes
- eMMC
- SGTL5000 sound
- All standard host USB ports
- mini PCIe
- IR receiver
- HDMI output

Functions routed out to the pin headers are not enabled and have
not been tested.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/imx6dl-hummingboard2.dts   |  50 ++++
 arch/arm/boot/dts/imx6q-hummingboard2.dts    |  58 +++++
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 372 +++++++++++++++++++++++++++
 4 files changed, 482 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb..f4d9677 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -348,6 +348,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-gw552x.dtb \
 	imx6dl-gw553x.dtb \
 	imx6dl-hummingboard.dtb \
+	imx6dl-hummingboard2.dtb \
 	imx6dl-icore.dtb \
 	imx6dl-nit6xlite.dtb \
 	imx6dl-nitrogen6x.dtb \
@@ -390,6 +391,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-gw553x.dtb \
 	imx6q-h100.dtb \
 	imx6q-hummingboard.dtb \
+	imx6q-hummingboard2.dtb \
 	imx6q-icore.dtb \
 	imx6q-icore-rqs.dtb \
 	imx6q-marsboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard2.dts b/arch/arm/boot/dts/imx6dl-hummingboard2.dts
new file mode 100644
index 0000000..3c99cc6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-hummingboard2.dts
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2017 Lucas Stach
+ * Based on work from Rabeeh Khoury and Russell King
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-hummingboard2.dtsi"
+
+/ {
+	model = "SolidRun HummingBoard2 Solo/DualLite";
+	compatible = "solidrun,hummingboard2/dl", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-hummingboard2.dts b/arch/arm/boot/dts/imx6q-hummingboard2.dts
new file mode 100644
index 0000000..33f1354
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-hummingboard2.dts
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2017 Lucas Stach
+ * Based on work from Rabeeh Khoury and Russell King
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-hummingboard2.dtsi"
+
+/ {
+	model = "SolidRun HummingBoard2 Dual/Quad";
+	compatible = "solidrun,hummingboard2/q", "fsl,imx6q";
+};
+
+&sata {
+	status = "okay";
+	fsl,transmit-level-mV = <1025>;
+	fsl,transmit-boost-mdB = <3330>;
+	fsl,transmit-atten-16ths = <9>;
+	fsl,receive-eq-mdB = <3000>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
new file mode 100644
index 0000000..35029e2
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -0,0 +1,372 @@
+/*
+ * Copyright (C) 2017 Lucas Stach
+ * Based on work from Russell King
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
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-microsom-ar8035.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	ir_recv: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_ir_rec>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_nvcc_sd2: regulator-nvcc-sd2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_reg_nvcc_sd2>;
+		compatible = "regulator-gpio";
+		regulator-name = "NVCC_SD2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+	};
+
+	reg_usbotg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_usbotg_vbus>;
+		regulator-name = "V_USB1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_usb2_vbus>;
+		regulator-name = "V_USB2";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb3_vbus: regulator-usb3-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_usb3_vbus>;
+		regulator-name = "V_USB3";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_usb4_vbus: regulator-usb4-vbus {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_usb4_vbus>;
+		regulator-name = "V_USB4";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	sound-sgtl5000 {
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "On-board Codec";
+		mux-ext-port = <5>;
+		mux-int-port = <1>;
+		ssi-controller = <&ssi1>;
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_hdmi>;
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_i2c1>;
+	status = "okay";
+
+	rtc: pcf8523 at 68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+
+	sgtl5000: sgtl5000 at 0a {
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		compatible = "fsl,sgtl5000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard2_sgtl5000>;
+		reg = <0x0a>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+		VDDD-supply = <&reg_1p8v>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_i2c2>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_i2c3>;
+	status = "okay";
+};
+
+&iomuxc {
+	hummingboard2 {
+		pinctrl_hummingboard2_ir_rec: hummingboard2-ir-rec {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x1b0b1
+			>;
+		};
+
+		pinctrl_hummingboard2_hdmi: hummingboard2-hdmi {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			>;
+		};
+
+		pinctrl_hummingboard2_i2c1: hummingboard2-i2c1 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_hummingboard2_i2c2: hummingboard2-i2c2 {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_hummingboard2_i2c3: hummingboard2-i2c3 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_hummingboard2_pcie_reset: hummingboard2-pcie-reset {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x1b0b1
+			>;
+		};
+
+		pinctrl_hummingboard2_reg_nvcc_sd2: hummingboard2-reg-nvcc-sd2 {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x1b0b0
+			>;
+		};
+
+		pinctrl_hummingboard2_sgtl5000: hummingboard2-sgtl5000 {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD 0x130b0
+				MX6QDL_PAD_KEY_COL0__AUD5_TXC 0x130b0
+				MX6QDL_PAD_KEY_ROW0__AUD5_TXD 0x110b0
+				MX6QDL_PAD_KEY_COL1__AUD5_TXFS 0x130b0
+				MX6QDL_PAD_GPIO_5__CCM_CLKO1 0x130b0
+			>;
+		};
+
+		pinctrl_hummingboard2_usb2_vbus: hummingboard2-usb2 {
+			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard2_usb3_vbus: hummingboard2-usb3 {
+			fsl,pins = <MX6QDL_PAD_SD4_DAT5__GPIO2_IO13 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard2_usb4_vbus: hummingboard2-usb4 {
+			fsl,pins = <MX6QDL_PAD_SD4_CLK__GPIO7_IO10 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard2_usbotg_id: hummingboard2-usbotg-id {
+			/*
+			 * Similar to pinctrl_usbotg_2, but we want it
+			 * pulled down for a fixed host connection.
+			 */
+			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+		};
+
+		pinctrl_hummingboard2_usbotg_vbus: hummingboard2-usbotg-vbus {
+			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard2_usdhc2: hummingboard2-usdhc2 {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f071
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x13059
+			>;
+		};
+
+		pinctrl_hummingboard2_usdhc2_100mhz: hummingboard2-usdhc2-100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f071
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+			>;
+		};
+
+		pinctrl_hummingboard2_usdhc2_200mhz: hummingboard2-usdhc2-200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f071
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170f9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100f9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
+			>;
+		};
+
+		pinctrl_hummingboard2_usdhc3: hummingboard2-usdhc3 {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
+				MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
+				MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
+				MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
+				MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
+				MX6QDL_PAD_SD3_RST__SD3_RESET  0x17059
+			>;
+		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_pcie_reset>;
+	reset-gpio = <&gpio2 11 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg {
+	disable-over-current;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_usbotg_id>;
+	vbus-supply = <&reg_usbotg_vbus>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_hummingboard2_usdhc2>;
+	pinctrl-1 = <&pinctrl_hummingboard2_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_hummingboard2_usdhc2_200mhz>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_nvcc_sd2>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_usdhc3>;
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
-- 
2.9.3
