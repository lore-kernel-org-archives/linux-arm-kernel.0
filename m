From: brian.kim@hardkernel.com (Brian Kim)
Date: Fri, 30 Sep 2016 18:17:39 +0900
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes
Message-ID: <1475227059-17462-1-git-send-email-brian.kim@hardkernel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable both gxbb USB controller and add a 5V regulator for the OTG port
VBUS

Signed-off-by: Brian Kim <brian.kim@hardkernel.com>
---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 8d89edc..997c671 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -64,6 +64,18 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	usb_pwr: regulator-usb-pwrs {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -149,6 +161,23 @@
 	pinctrl-names = "default";
 };
 
+&usb0_phy {
+	status = "okay";
+	phy-supply = <&usb_pwr>;
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 /* SD */
 &sd_emmc_b {
 	status = "okay";
-- 
2.7.4
