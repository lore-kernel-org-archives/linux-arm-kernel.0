From: ashutosh.s@phytec.in (Ashutosh singh)
Date: Tue, 18 Feb 2014 19:16:23 +0530
Subject: [PATCH v2 2/4] Phytec phyFLEX-i.MX6 : Added USB_HOST Support
In-Reply-To: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
References: <1392731185-4885-1-git-send-email-ashutosh.s@phytec.in>
Message-ID: <1392731185-4885-2-git-send-email-ashutosh.s@phytec.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for USB_HOST on Phytec phyFLEX-i.MX6 Quad module.

Signed-off-by: Ashutosh singh <ashutosh.s@phytec.in>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |    4 ++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   14 ++++++++++++++
 2 files changed, 18 insertions(+)

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
index e025ad2..12a02f7 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -26,6 +26,14 @@
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio4 15 0>;
 	};
+
+	reg_usb_h1_vbus: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 0 0>;
+	};
 };
 
 &ecspi3 {
@@ -143,6 +151,7 @@
 				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
 				MX6QDL_PAD_DI0_PIN15__GPIO4_IO17  0x80000000 /* PMIC interrupt */
 				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x80000000 /* USB_OTG_PWR_EN */
+				MX6QDL_PAD_GPIO_0__USB_H1_PWR     0x80000000 /* USB_H1_PWR_EN */
 			>;
 		};
 	};
@@ -171,6 +180,11 @@
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
