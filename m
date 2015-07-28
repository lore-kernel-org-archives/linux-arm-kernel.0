From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 28 Jul 2015 08:27:10 -0700
Subject: [PATCH v3 2/2] ARM: dts: ventana: Add ext-reset support
In-Reply-To: <1438097230-2653-1-git-send-email-tharvey@gateworks.com>
References: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
 <1438097230-2653-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1438097230-2653-3-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gateworks Ventana boards have a PMIC that can be used to regulate the
CPU voltage rails for DVFS support. In order to ensure this PMIC is properly
reset the watchdog needs to be configured to assert its external reset
signal.

Additionally the pad used for WDOG_B needs to be configured which we add to
iomux.

Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - no changes
v2:
 - moved pinctl to wdog group instead of hog
 - updated property name

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 12 ++++++++++++
 6 files changed, 78 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 7b31fdb..d81bd72 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -210,6 +210,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw51xx {
 		pinctrl_enet: enetgrp {
@@ -328,5 +334,11 @@
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1b66328..0d8f201 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -326,6 +326,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw52xx {
 		pinctrl_audmux: audmuxgrp {
@@ -501,5 +507,11 @@
 				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 7c51839..36f9ec6 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -332,7 +332,14 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	ext-reset-output;
+};
+
 &iomuxc {
+
 	imx6qdl-gw53xx {
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
@@ -508,5 +515,11 @@
 				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 929e0b3..0c1150f 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -425,6 +425,17 @@
 	status = "okay";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	ext-reset-output;
+	status = "okay";
+};
+
 &iomuxc {
 	imx6qdl-gw54xx {
 		pinctrl_audmux: audmuxgrp {
@@ -600,5 +611,11 @@
 				MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT3__WDOG2_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 741f3d5..883e577 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -227,6 +227,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw51xx {
 		pinctrl_flexcan1: flexcan1grp {
@@ -309,5 +315,11 @@
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index d1e5048..07674c2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -185,6 +185,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw552x {
 		pinctrl_gpio_leds: gpioledsgrp {
@@ -262,5 +268,11 @@
 				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
 			>;
                 };
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			>;
+		};
 	};
 };
-- 
1.9.1
