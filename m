From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:45:54 +0100
Subject: [PATCH] ARM: dts: imx6: Add DFI FS700-M60 board support
Message-ID: <1389876354-24341-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DFI FS700-M60 is a q7 board with i.MX6 quad, dual, duallite or solo
SoC. This adds support for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts   |  23 +++++
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts    |  23 +++++
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi | 145 +++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index aeb8053..485ed47 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -158,6 +158,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-qsrb.dtb \
 	imx53-smd.dtb \
 	imx53-voipac-bsb.dtb \
+	imx6dl-dfi-fs700-m60.dtb \
 	imx6dl-gw51xx.dtb \
 	imx6dl-gw52xx.dtb \
 	imx6dl-gw53xx.dtb \
@@ -170,6 +171,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
 	imx6q-cm-fx6.dtb \
+	imx6q-dfi-fs700-m60.dtb \
 	imx6q-dmo-edmqmx6.dtb \
 	imx6q-gw51xx.dtb \
 	imx6q-gw52xx.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
new file mode 100644
index 0000000..994f96a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2013 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __DTS_V1__
+#define __DTS_V1__
+/dts-v1/;
+#endif
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-dfi-fs700-m60.dtsi"
+
+/ {
+	model = "DFI FS700-M60-6DL i.MX6dl Q7 Board";
+	compatible = "dfi,fs700-m60-6dl", "dfi,fs700e-m60", "fsl,imx6dl";
+};
diff --git a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
new file mode 100644
index 0000000..fd0ad9a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2013 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __DTS_V1__
+#define __DTS_V1__
+/dts-v1/;
+#endif
+
+#include "imx6q.dtsi"
+#include "imx6qdl-dfi-fs700-m60.dtsi"
+
+/ {
+	model = "DFI FS700-M60-6QD i.MX6qd Q7 Board";
+	compatible = "dfi,fs700-m60-6qd", "dfi,fs700e-m60", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
new file mode 100644
index 0000000..ca3c748
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -0,0 +1,145 @@
+/ {
+	regulators {
+		compatible = "simple-bus";
+
+		dummy_reg: fixed at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "dummy-supply";
+		};
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = &uart1;
+	};
+};
+
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 24 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst,sst25vf040b", "m25p80";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	status = "okay";
+	phy-mode = "rgmii";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx6qdl-dfi-fs700-m60 {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x80000000 /* PMIC irq */
+				MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x80000000 /* MAX11801 irq */
+				MX6QDL_PAD_NANDF_D5__GPIO2_IO05 0x000030b0 /* Backlight enable */
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000 /* SD2 card detect */
+			>;
+		};
+
+		pinctrl_enet: enetgrp {
+			fsl,pins = <MX6QDL_ENET_PINGRP1>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <MX6QDL_I2C2_PINGRP1>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <MX6QDL_UART1_PINGRP1>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <MX6QDL_USBOTG_PINGRP2>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <MX6QDL_USDHC2_PINGRP_D4>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <MX6QDL_USDHC3_PINGRP_D4>;
+		};
+
+		pinctrl_usdhc4: usdhc4grp {
+			fsl,pins = <MX6QDL_USDHC4_PINGRP_D8>;
+		};
+	};
+
+	ecspi3 {
+		pinctrl_ecspi3: ecspi3_csgrp {
+			fsl,pins = <
+				MX6QDL_ECSPI3_PINGRP1
+				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
+			>;
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc2 { /* module slot */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio2 2 0>;
+	status = "okay";
+};
+
+&usdhc3 { /* baseboard slot */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+};
+
+&usdhc4 { /* eMMC */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
-- 
1.8.5.2
