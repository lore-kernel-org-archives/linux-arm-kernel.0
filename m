From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:05 +0100
Subject: [PATCH 64/77] ARM: dts: sun8i: a23/a33: Remove underscores from nodes
 names
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <a63e38a6c93909fe248ffb52d98d47cb4c16ea81.1543321707.git-series.maxime.ripard@bootlin.com>
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
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts       | 2 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi               | 2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts               | 2 +-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index 42726576a6a9..317763069c0a 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -84,7 +84,7 @@
 };
 
 &r_pio {
-	led_pin_d978: led_pin_d978 at 0 {
+	led_pin_d978: led-pin {
 		pins = "PL5";
 		function = "gpio_out";
 		drive-strength = <20>;
diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
index e3ca8a94d690..719ad769b837 100644
--- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
+++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
@@ -83,7 +83,7 @@
 };
 
 &r_pio {
-	wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
+	wifi_pwrseq_pin_q8: wifi-pwrseq-pins {
 		pins = "PL6", "PL7", "PL11";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 62f53291ff22..85576092f5d9 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -159,7 +159,7 @@
 };
 
 &pio {
-	usb0_id_det: usb0_id_detect_pin at 0 {
+	usb0_id_det: usb0-id-detect-pin {
 		pins = "PD10";
 		function = "gpio_in";
 		bias-pull-up;
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 12a2ad67844e..787a3121e179 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -94,7 +94,7 @@
 };
 
 &pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+	usb0_id_detect_pin: usb0-id-detect-pin {
 		pins = "PH8";
 		function = "gpio_in";
 		bias-pull-up;
-- 
git-series 0.9.1
