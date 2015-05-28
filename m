From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 28 May 2015 15:54:37 -0700
Subject: [PATCH 2/2] ARM: dts: ventana: Add ext-reset support
In-Reply-To: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1432853677-5150-3-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gateworks Ventana boards have a PMIC that can be used to regulate the
CPU voltage rails for DVFS support. In order to ensure this PMIC is properly
reset the watchdog needs to be configured to assert its external reset
signal.

Additionally the pad used for WDOG_B needs to be configured which we add to
a hog group for lack of a better location.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 13 +++++++++++++
 6 files changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index f2867c4..740c6c4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -210,8 +210,21 @@
 	status = "okay";
 };
 
+&wdog1 {
+	ext-reset;
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx6qdl-gw51xx {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index b5756c2..1b06f18 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -323,8 +323,21 @@
 	status = "okay";
 };
 
+&wdog1 {
+	ext-reset;
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx6qdl-gw52xx {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
+
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 86f03c1..65e5c01 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -329,8 +329,21 @@
 	status = "okay";
 };
 
+&wdog1 {
+	ext-reset;
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx6qdl-gw53xx {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
+
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 4a8d97f..f108781 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -422,8 +422,26 @@
 	status = "okay";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	status = "okay";
+	ext-reset;
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx6qdl-gw54xx {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT3__WDOG2_B		0x1b0b0
+			>;
+		};
+
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index d1866a0..ae3c2a4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -227,8 +227,20 @@
 	status = "okay";
 };
 
+&wdog1 {
+	ext-reset;
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
 	imx6qdl-gw51xx {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
+
 		pinctrl_flexcan1: flexcan1grp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 5c6587f..52eaf42 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -185,8 +185,21 @@
 	status = "okay";
 };
 
+&wdog1 {
+	ext-reset;
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	imx6qdl-gw552x {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
-- 
1.9.1
