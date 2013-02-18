From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 18 Feb 2013 10:06:44 +0800
Subject: [PATCH v2 1/1] ARM: dts: imx6q-sabresd: Add USB support
Message-ID: <1361153204-6426-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support for imx6q sabresd board

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
Changes for v2:
- Changes the dt file style based on 3.9-rc1
- Add one blank line between node

 arch/arm/boot/dts/imx6q-sabresd.dts |   25 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi        |    6 ++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index 2dea304..bafaccd 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -21,6 +21,19 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
+	regulators {
+		compatible = "simple-bus";
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
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -62,6 +75,18 @@
 	};
 };
 
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg_2>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cba021e..0125250 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -207,6 +207,12 @@
 							1592 0x17059	/* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
 						>;
 					};
+
+					pinctrl_usbotg_2: usbotggrp-2 {
+					fsl,pins = <
+							1591 0x17059	/* MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID */
+						>;
+					};
 				};
 
 				usdhc2 {
-- 
1.7.0.4
