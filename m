From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Jun 2016 17:29:15 +0800
Subject: [PATCH v2] ARM: dts: sun5i: q8-common: Enable USB-based WiFi
Message-ID: <1466674155-3365-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The early A13 Q8 tablets all use a Realtek WiFi module connected to
USB1. The module is powered by AXP209's LDO3 at 3.3V.

Move the related settings from sun5i-a13-q8-tablet.dts to
sun5i-q8-common.dtsi, for all q8-based tablets.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:

  - Move the WiFi module settings from sun5i-a13-q8-tablet.dts
---
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 10 ----------
 arch/arm/boot/dts/sun5i-q8-common.dtsi    |  7 +++++++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index 72e93acb5a9e..dce77825571d 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -48,13 +48,3 @@
 	model = "Q8 A13 Tablet";
 	compatible = "allwinner,q8-a13", "allwinner,sun5i-a13";
 };
-
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_ldo3>;
-};
diff --git a/arch/arm/boot/dts/sun5i-q8-common.dtsi b/arch/arm/boot/dts/sun5i-q8-common.dtsi
index b6af9a498eda..a5de28d12b16 100644
--- a/arch/arm/boot/dts/sun5i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun5i-q8-common.dtsi
@@ -191,6 +191,12 @@
 	regulator-name = "avcc";
 };
 
+&reg_ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
 &reg_usb0_vbus {
 	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
 	status = "okay";
@@ -231,5 +237,6 @@
 	usb0_vbus_det-gpio = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_usb0_vbus>;
+	usb1_vbus-supply = <&reg_ldo3>;
 	status = "okay";
 };
-- 
2.8.1
