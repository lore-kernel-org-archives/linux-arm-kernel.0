From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:22:52 +0200
Subject: [PATCH v2 3/5] ARM: dts: sun4i: Remove underscores from nodes names
In-Reply-To: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
References: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
Message-ID: <72b12175526c13b3d4c36dade0e0da8bf1e832df.1507580565.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some GPIO pinctrl nodes cannot be easily removed, because they would also
change the pin configuration, for example to add a pull resistor or change
the current delivered by the pin.

Those nodes still have underscores and unit-addresses in their node names
in our DTs, so adjust their name to remove the warnings. Use that occasion
to also fix some poorly chosen node-names.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  | 4 ++--
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 4 ++--
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts | 6 +++---
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts     | 4 ++--
 arch/arm/boot/dts/sun4i-a10-inet1.dts            | 4 ++--
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        | 4 ++--
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts     | 8 ++++----
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        | 2 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   | 6 +++---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          | 4 ++--
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 6 +++---
 11 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
index b2dbdac19c0f..dfc88aee4fe3 100644
--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
@@ -133,13 +133,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index b48cc70aa6c2..d5ba5400a975 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -155,13 +155,13 @@
 };
 
 &pio {
-	led_pins_cubieboard: led_pins at 0 {
+	led_pins_cubieboard: led-pins {
 		pins = "PH20", "PH21";
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index acbf692e837f..147cbc5e08ac 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -75,7 +75,7 @@
 		max-microvolt = <3000000>;
 	};
 
-	reg_motor: reg_motor {
+	reg_motor: reg-motor {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc-motor";
 		regulator-min-microvolt = <3000000>;
@@ -160,13 +160,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
index f5e9b643007e..35c57d065dd8 100644
--- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
@@ -88,13 +88,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index 2374ee7dfc64..9482e831a9a1 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -166,13 +166,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
index c76f2538e3a2..4b5c91c8e85b 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
@@ -152,13 +152,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
index 4188907b0477..13224f5ac166 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
@@ -59,7 +59,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys-polled";
 		pinctrl-names = "default";
 		pinctrl-0 = <&key_pins_inet9f>;
@@ -310,7 +310,7 @@
 };
 
 &pio {
-	key_pins_inet9f: key_pins at 0 {
+	key_pins_inet9f: key-pins {
 		pins = "PA0", "PA1", "PA3", "PA4",
 		       "PA5", "PA6", "PA8", "PA9",
 		       "PA11", "PA12", "PA13",
@@ -320,13 +320,13 @@
 		bias-pull-up;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 86c7c3fcaf9c..435c551aef0f 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -150,7 +150,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 3689b8c3b7a0..2d1b4329f54a 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -158,19 +158,19 @@
 };
 
 &pio {
-	led_pins_olinuxinolime: led_pins at 0 {
+	led_pins_olinuxinolime: led-pin {
 		pins = "PH2";
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index dbb310f65a6e..6e140547b638 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -74,7 +74,7 @@
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -158,7 +158,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 46e485ff925b..5081303f79e7 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -101,7 +101,7 @@
 &i2c2 {
 	status = "okay";
 
-	pixcir_ts at 5c {
+	touchscreen at 5c {
 		compatible = "pixcir,pixcir_tangoc";
 		reg = <0x5c>;
 		interrupt-parent = <&pio>;
@@ -148,13 +148,13 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+	usb0_vbus_detect_pin: usb0-vbus-detect-pin {
 		pins = "PH5";
 		function = "gpio_in";
 		bias-pull-down;
-- 
git-series 0.9.1
