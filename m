From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 27 Oct 2016 14:47:18 -0300
Subject: [PATCH 2/2] ARM: dts: exynos: Use macro for PWM signal polarity in
 Exynos5 boards
In-Reply-To: <1477590438-18095-1-git-send-email-javier@osg.samsung.com>
References: <1477590438-18095-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1477590438-18095-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the PWM_POLARITY_INVERTED macro instead of the hardcoded number
0 makes the DTS easier to read.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 3 ++-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 3 ++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 3 ++-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 2 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    | 5 +++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 3 ++-
 7 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 8f3a80430748..4df36f7263fd 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/pwm/pwm.h>
 #include "exynos5250.dtsi"
 
 / {
@@ -198,7 +199,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index c4de1353e5df..56adaac1f4ec 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -40,7 +40,7 @@
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm 0 20972 0>;
+		pwms = <&pwm 0 20972 PWM_POLARITY_INVERTED>;
 		cooling-min-state = <0>;
 		cooling-max-state = <3>;
 		#cooling-cells = <2>;
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 1f964ec35c5e..d83a12bb7112 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77802.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
 #include "exynos5420.dtsi"
 #include "exynos5420-cpus.dtsi"
@@ -37,7 +38,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
 		power-supply = <&tps65090_fet1>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 246d298557f5..791af504a79f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/samsung,s2mps11.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
 #include "exynos5422-cpus.dtsi"
@@ -51,7 +52,7 @@
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm 0 20972 0>;
+		pwms = <&pwm 0 20972 PWM_POLARITY_INVERTED>;
 		cooling-min-state = <0>;
 		cooling-max-state = <3>;
 		#cooling-cells = <2>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 2faf88627a48..93ac1d201f16 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -24,7 +24,7 @@
 
 		blueled {
 			label = "blue:heartbeat";
-			pwms = <&pwm 2 2000000 0>;
+			pwms = <&pwm 2 2000000 PWM_POLARITY_INVERTED>;
 			pwm-names = "pwm2";
 			max_brightness = <255>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
index 0ed30206625c..1e3d65d34167 100644
--- a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
+++ b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
@@ -12,6 +12,7 @@
 */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	pwmleds {
@@ -19,7 +20,7 @@
 
 		greenled {
 			label = "green:mmc0";
-			pwms = <&pwm 1 2000000 0>;
+			pwms = <&pwm 1 2000000 PWM_POLARITY_INVERTED>;
 			pwm-names = "pwm1";
 			/*
 			 * Green LED is much brighter than the others
@@ -31,7 +32,7 @@
 
 		blueled {
 			label = "blue:heartbeat";
-			pwms = <&pwm 2 2000000 0>;
+			pwms = <&pwm 2 2000000 PWM_POLARITY_INVERTED>;
 			pwm-names = "pwm2";
 			max_brightness = <255>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index f9ff7f07ae0c..b1bf73f51e9c 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77802.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
 #include "exynos5800.dtsi"
 #include "exynos5420-cpus.dtsi"
@@ -35,7 +36,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpx2 2 GPIO_ACTIVE_HIGH>;
-- 
2.7.4
