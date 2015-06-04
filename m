From: tharvey@gateworks.com (Tim Harvey)
Date: Thu,  4 Jun 2015 13:16:00 -0700
Subject: [PATCH v2 2/2] ARM: dts: ventana: Add ext-reset support
In-Reply-To: <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1433448960-9257-3-git-send-email-tharvey@gateworks.com>
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
index f2867c4..8146452 100644
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
@@ -329,5 +335,11 @@
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
index b5756c2..e4752a7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -323,6 +323,12 @@
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
@@ -472,5 +478,11 @@
 				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x1b0b0 /* CD */
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
index 86f03c1..7061e75 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -329,7 +329,14 @@
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
@@ -479,5 +486,11 @@
 				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0 /* CD */
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
index 4a8d97f..98439e1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -422,6 +422,17 @@
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
@@ -570,5 +581,11 @@
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
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
index d1866a0..0924b6b 100644
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
@@ -310,5 +316,11 @@
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
index 5c6587f..4ba859f 100644
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
@@ -263,5 +269,11 @@
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
