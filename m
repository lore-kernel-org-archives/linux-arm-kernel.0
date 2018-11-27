From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:12 +0100
Subject: [PATCH 11/77] ARM: dts: sun5i: Remove card detect pull-up
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <f3867ba6c6fcfcd95914c5466d376207a66505b9.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards usually have an external pull-up on the card-detect signal, so
there's no need to add another one.

This also removes a DTC warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts           |  8 +------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts           |  8 +------
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                 | 10 +-------
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts       | 16 +----------
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts          |  8 +------
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts               | 10 +-------
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts |  8 +------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts               |  8 +------
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts        |  8 +------
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts              |  8 +------
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi   |  8 +------
 11 files changed, 12 insertions(+), 88 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index 39504d720efc..9e076e748b78 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -90,7 +90,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_t003>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -106,12 +106,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_t003: mmc0_cd_pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_t003: led_pins at 0 {
 		pins = "PB2";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index d5bca68ca6ca..61d0bab8cbbd 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -100,7 +100,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_t004>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -132,12 +132,6 @@
 		bias-pull-up;
 	};
 
-	mmc0_cd_pin_t004: mmc0_cd_pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_t004: led_pins at 0 {
 		pins = "PB2";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index b17c036293d6..822f1b2ac6d3 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -87,7 +87,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_mk802>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -111,14 +111,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_mk802: mmc0_cd_pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_usb1_vbus {
 	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 3ffae227bab3..15889639a841 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -198,7 +198,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino_micro>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -207,7 +207,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>, <&mmc1_cd_pin_olinuxino_micro>;
+	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 13 GPIO_ACTIVE_LOW>; /* PG13 */
@@ -223,18 +223,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
-	mmc1_cd_pin_olinuxino_micro: mmc1_cd_pin at 0 {
-		pins = "PG13";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_olinuxino: led_pins at 0 {
 		pins = "PE3";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index 1e713a42e34f..ba2d2e604d54 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -77,7 +77,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_r7>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
@@ -98,12 +98,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_r7: mmc0_cd_pin at 0 {
-		pins = "PG1";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_r7: led_pins at 0 {
 		pins = "PB2";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index d8bff29f1049..69581f8c4e8f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -123,7 +123,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_wobo_i5>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 */
@@ -138,14 +138,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_wobo_i5: mmc0_cd_pin at 0 {
-		pins = "PB3";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 30a86cadf5a5..4b892f609240 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -122,7 +122,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_d709>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -134,12 +134,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_d709: mmc0_cd_pin at 0 {
-		pins = "PG0";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		pins = "PG1";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index f6211c22e4dc..ff845f48c832 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -117,7 +117,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -133,12 +133,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_h702: mmc0_cd_pin at 0 {
-		pins = "PG0";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PG2";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 0e107ff5cff0..8d104a0395dd 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -96,7 +96,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxinom>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -112,12 +112,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_olinuxinom: mmc0_cd_pin at 0 {
-		pins = "PG0";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_olinuxinom: led_pins at 0 {
 		pins = "PG9";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index d963cac2a04d..1703b5379f6b 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -191,7 +191,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_olinuxino>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -207,12 +207,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_olinuxino: mmc0_cd_pin at 0 {
-		pins = "PG0";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_olinuxino: led_pins at 0 {
 		pins = "PG9";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index eafb362e3993..12c80be63693 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -121,7 +121,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
@@ -133,12 +133,6 @@
 };
 
 &pio {
-	mmc0_cd_pin: mmc0_cd_pin at 0 {
-		pins = "PG0";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
 		pins = "PG1";
 		function = "gpio_in";
-- 
git-series 0.9.1
