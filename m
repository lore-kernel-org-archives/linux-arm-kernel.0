From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Mar 2017 05:23:15 +0800
Subject: [PATCH] ARM: sun8i: a23/a33: drop bl_en_pin GPIO pinmux in reference
 design DTSI
Message-ID: <20170317212315.2561-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bl_en_pin GPIO pinmux is configured as "gpio_in", which makes it
conflicts with the real GPIO usage (out), and makes the backlight not
usable.

Drop the GPIO pinmux for it, thus this GPIO can be correctly used.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---

Please patch latest git tree master too, as this issue affects 4.11-rc.

 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 9f097a3d723d..4ae638901159 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -50,8 +50,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin>;
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
@@ -83,11 +81,6 @@
 };
 
 &pio {
-	bl_en_pin: bl_en_pin at 0 {
-		pins = "PH6";
-		function = "gpio_in";
-	};
-
 	mmc0_cd_pin: mmc0_cd_pin at 0 {
 		pins = "PB4";
 		function = "gpio_in";
-- 
2.12.0
