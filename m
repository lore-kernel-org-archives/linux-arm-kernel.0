From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Thu, 20 Feb 2014 11:20:16 +0530
Subject: [PATCH v3 2/4] ARM: dts: imx6q-phytec: Added USB_HOST Support
In-Reply-To: <1392875418-9034-1-git-send-email-ashutosh.s@phytec.in>
References: <1392875418-9034-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <1392875418-9034-2-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB_HOST on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 87c3702..91aecba 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -25,6 +25,10 @@
 	status = "okay";
 };
 
+&usbh1 {
+	status = "okay";
+};
+
 &usbotg {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index ee07896..b1a78a0 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -32,6 +32,15 @@
 			regulator-max-microvolt = <5000000>;
 			gpio = <&gpio4 15 0>;
 		};
+
+		reg_usb_h1_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 0 0>;
+		};
 	};
 };
 
@@ -195,6 +204,12 @@
 			>;
 		};
 
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_0__USB_H1_PWR		0x80000000
+			>;
+		};
+
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
@@ -248,6 +263,13 @@
 	status = "disabled";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	status = "disabled";
+};
+
 &usbotg {
 	vbus-supply = <&reg_usb_otg_vbus>;
 	pinctrl-names = "default";
-- 
1.7.9.5
