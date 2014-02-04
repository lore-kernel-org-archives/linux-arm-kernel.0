From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Tue, 4 Feb 2014 10:04:53 +0530
Subject: [PATCH 1/3] Phytec phyFLEX-i.MX6 : Added USB_HOST Support
Message-ID: <1391488493-30662-1-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB_HOST on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   15 +++++++++++++++
 2 files changed, 19 insertions(+)

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
index e682bf8..fb39dae 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -27,6 +27,15 @@
 		gpio = <&gpio4 15 0>;
 		enable-active-low;
 	};
+
+	reg_usb_h1_vbus: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 0 0>;
+		enable-active-low;
+	};
 };
 
 &ecspi3 {
@@ -144,6 +153,7 @@
 				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
 				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000 /* PMIC interrupt */
 				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* USB_OTG_PWR_EN */
+				MX6QDL_PAD_GPIO_0__USB_H1_PWR     0x80000000 /* USB_H1_PWR_EN */
 			>;
 		};
 	};
@@ -172,6 +182,11 @@
 	status = "disabled";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "disabled";
+};
+
 &usbotg {
 	vbus-supply = <&reg_usb_otg_vbus>;
 	pinctrl-names = "default";
-- 
1.7.9.5
