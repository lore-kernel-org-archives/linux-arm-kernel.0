From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:47 +0100
Subject: [PATCH 46/77] ARM: dts: sun7i: Remove underscores from nodes names
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <a428495b460780df6cfd6fb678ce8d15bb247448.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         | 2 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 2 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts       | 2 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts        | 2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts   | 2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   | 6 +++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  | 6 +++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  | 8 ++++----
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts    | 2 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts         | 2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts    | 2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         | 2 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts   | 2 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 2 +-
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index af56ae95c63f..c14c517a35af 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -248,7 +248,7 @@
 		"IO-6", "IO-3", "IO-2", "IO-0", "", "", "", "",
 		"", "", "", "", "", "", "", "";
 
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 9a027764cda4..2982d0521f06 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -180,7 +180,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
index ad97f6f2cc2c..2bd4f281f31a 100644
--- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
@@ -129,7 +129,7 @@
 };
 
 &pio {
-	led_pins_itead_core: led_pins at 0 {
+	led_pins_itead_core: led-pins {
 		pins = "PH20","PH21";
 		function = "gpio_out";
 		drive-strength = <20>;
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 32e204fe8c15..3d4cd05813e8 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -236,7 +236,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 8f8a77121e80..cf3a61eed691 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -239,7 +239,7 @@
 };
 
 &pio {
-	led_pins_olimex_som_evb: led_pins at 0 {
+	led_pins_olimex_som_evb: led-pins {
 		pins = "PH2";
 		function = "gpio_out";
 		drive-strength = <20>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 7d6a90678025..454b0c433e75 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -175,19 +175,19 @@
 };
 
 &pio {
-	led_pins_olinuxinolime: led_pins at 0 {
+	led_pins_olinuxinolime: led-pins {
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
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 9ea84cf6437b..0a8e243d8e7b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -180,19 +180,19 @@
 };
 
 &pio {
-	led_pins_olinuxinolime: led_pins at 0 {
+	led_pins_olinuxinolime: led-pins {
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
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 4cef69e90b2f..718b5209643b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -252,24 +252,24 @@
 };
 
 &pio {
-	gmac_txerr: gmac_txerr at 0 {
+	gmac_txerr: gmac-txerr-pin {
 		pins = "PA17";
 		function = "gmac";
 	};
 
-	led_pins_olinuxino: led_pins at 0 {
+	led_pins_olinuxino: led-pins {
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
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index 192d907fee71..ddb713209bb2 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -183,7 +183,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index c71d819cd0af..d35705345c10 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -140,7 +140,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index 1ba1dd6de244..6e64315d1a8b 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -173,7 +173,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index 77a49e8b3d20..b6a9cef86c31 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -173,7 +173,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 23b7d127e14f..3b1fc4cb61d3 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -165,7 +165,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index 1df18959d2a9..ae4febdea552 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -156,7 +156,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
-- 
git-series 0.9.1
