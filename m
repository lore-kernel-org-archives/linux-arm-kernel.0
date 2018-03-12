From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Mar 2018 12:23:53 +0800
Subject: [PATCH 1/4] ARM: dts: sun8i: a33: Drop GPIO pinmux settings for
 A33-OLinuXino
In-Reply-To: <20180312042356.18625-1-wens@csie.org>
References: <20180312042356.18625-1-wens@csie.org>
Message-ID: <20180312042356.18625-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Normal GPIO usage does not need an additional pinmix setting. Exclusive
usage of the pin will be guaranteed by the driver.

Drop the extra pinmux settings.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 9757265c58d4..6349e0bec9a3 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -62,8 +62,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pin_olinuxino>;
 
 		green {
 			label = "a33-olinuxino:green:usr";
@@ -78,7 +76,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -89,23 +87,6 @@
 	status = "okay";
 };
 
-&pio {
-	led_pin_olinuxino: led_pins at 0 {
-		pins = "PB7";
-		function = "gpio_out";
-	};
-
-	mmc0_cd_pin_olinuxino: mmc0_cd_pin at 0 {
-		pins = "PB4";
-		function = "gpio_in";
-	};
-
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		pins = "PB3";
-		function = "gpio_in";
-	};
-};
-
 &r_rsb {
 	status = "okay";
 
@@ -210,8 +191,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>;
 	usb0_id_det-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
-- 
2.16.2
