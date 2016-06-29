From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 29 Jun 2016 06:31:03 -0700
Subject: [PATCH] ARM: dts: imx: ventana: Add ext watchdog reset
Message-ID: <1467207063-4774-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bc677ff42e81bbf78308a7b66cf7b63b0f5c26b0 adds a device-tree property
to specify that an external watchdog reset is used to reset other
portions of the board and not just the IMX6 SoC.

This adds the property to the proper watchdog as well as the pinmux for
the Gateworks Ventana boards that use this external watchdog reset to
reset the PMIC which will reset all the PMIC power rails and not just
a chip-level IMX6 reset. This helps to work around various system issues
that can cause a hang when coming out of reset.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 17 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 12 ++++++++++++
 6 files changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 9d7ab6c..1340e27 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -228,6 +228,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw51xx {
 		pinctrl_enet: enetgrp {
@@ -364,5 +370,11 @@
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
index 7191b84..8bf1020 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -353,6 +353,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw52xx {
 		pinctrl_audmux: audmuxgrp {
@@ -549,5 +555,11 @@
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
index 40d06b0..a3dd0c4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -351,6 +351,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw53xx {
 		pinctrl_audmux: audmuxgrp {
@@ -539,5 +545,11 @@
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
index d6dbe2a..5a8dbab 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -453,6 +453,17 @@
 	status = "okay";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
 &iomuxc {
 	imx6qdl-gw54xx {
 		pinctrl_audmux: audmuxgrp {
@@ -654,5 +665,11 @@
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
index 118bea5..4b9fef8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -239,6 +239,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw51xx {
 		pinctrl_flexcan1: flexcan1grp {
@@ -333,5 +339,11 @@
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
index f27f184..805e236 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -197,6 +197,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	imx6qdl-gw552x {
 		pinctrl_gpio_leds: gpioledsgrp {
@@ -286,5 +292,11 @@
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
