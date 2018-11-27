From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:21 +0100
Subject: [PATCH 20/77] ARM: dts: sun5i: Remove underscores from nodes names
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <997f9f1b7437b3bfc42b2f508f1d9ecd34c1e327.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO pinctrl nodes cannot be easily removed, because they would also
change the pin configuration, for example to add a pull resistor or change
the current delivered by the pin.

Those nodes still have underscores and unit-addresses in their node names
in our DTs, so adjust their name to remove the warnings. Use that occasion
to also fix some poorly chosen node-names.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts           | 2 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts           | 4 ++--
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts       | 4 ++--
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts          | 2 +-
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts | 4 ++--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts               | 2 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts        | 6 +++---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts              | 6 +++---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts               | 2 +-
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi   | 4 ++--
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
index 30c8e7b5fabc..f5c50b66290a 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
@@ -106,7 +106,7 @@
 };
 
 &pio {
-	led_pins_t003: led_pins at 0 {
+	led_pins_t003: led-pin {
 		pins = "PB2";
 		function = "gpio_out";
 		drive-strength = <20>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
index 781be07547a3..648f03d2132b 100644
--- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
@@ -126,13 +126,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG12";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	led_pins_t004: led_pins at 0 {
+	led_pins_t004: led-pin {
 		pins = "PB2";
 		function = "gpio_out";
 		drive-strength = <20>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index b1fe1226cb1e..ae6d4a0bb9c9 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -223,13 +223,13 @@
 };
 
 &pio {
-	led_pins_olinuxino: led_pins at 0 {
+	led_pins_olinuxino: led-pin {
 		pins = "PE3";
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG12";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
index a32025e57592..afbda5dd773b 100644
--- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
@@ -98,7 +98,7 @@
 };
 
 &pio {
-	led_pins_r7: led_pins at 0 {
+	led_pins_r7: led-pin {
 		pins = "PB2";
 		function = "gpio_out";
 		drive-strength = <20>;
diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
index 34c932564daf..49eaa1920088 100644
--- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
+++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
@@ -134,13 +134,13 @@
 };
 
 &pio {
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PG1";
 		function = "gpio_in";
 		bias-pull-down;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG2";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 4f5b1247a427..082a1501eaf1 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -133,7 +133,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG2";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 70445d28c20a..cf5f730d5efa 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -112,19 +112,19 @@
 };
 
 &pio {
-	led_pins_olinuxinom: led_pins at 0 {
+	led_pins_olinuxinom: led-pin {
 		pins = "PG9";
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG2";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PG1";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index 0dafbdb00599..7c506de4a1ee 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -205,19 +205,19 @@
 };
 
 &pio {
-	led_pins_olinuxino: led_pins at 0 {
+	led_pins_olinuxino: led-pin {
 		pins = "PG9";
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG2";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PG1";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index abc8402fe04e..732873cbeedc 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -95,7 +95,7 @@
 };
 
 &pio {
-	i2c_lcd_pins: i2c_lcd_pin at 0 {
+	i2c_lcd_pins: i2c-lcd-pin {
 		pins = "PG10", "PG12";
 		function = "gpio_out";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index ca7556177c1b..b046436ff773 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -137,13 +137,13 @@
 };
 
 &pio {
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PG1";
 		function = "gpio_in";
 		bias-pull-down;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PG2";
 		function = "gpio_in";
 		bias-pull-up;
-- 
git-series 0.9.1
