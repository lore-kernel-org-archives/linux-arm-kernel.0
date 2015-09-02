From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Wed,  2 Sep 2015 23:48:08 +0900
Subject: [PATCH] ARM: dts: Fix LEDs on exynos5422-odroidxu3
Message-ID: <1441205288-22047-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LEDs on Odroid XU3 family boards could not properly probe because PWM
outputs were reduced only to PWM for fan. Fix this to:
 - Odroid XU3 and XU3-Lite: 4 outputs (although the PWM for MIPI
   probably is redundant because board does not have MIPI connector
   available);
 - Odroid XU4: 2 outputs.

This fixes warnings on dmesg:
[    4.838712] samsung-pwm 12dd0000.pwm: tried to request PWM channel 1 without output
[    4.838725] leds_pwm pwmleds: unable to request PWM for green:mmc0: -22
[    4.838767] leds_pwm: probe of pwmleds failed with error -22

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---

Patch depends/is rebased on latest DTS for Odroid XU4 board:
 - http://www.spinics.net/lists/arm-kernel/msg442474.html
 - http://www.spinics.net/lists/arm-kernel/msg442475.html
---
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 1 -
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      | 1 -
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index 379cd61178ee..b1b36081f343 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -63,7 +63,6 @@
 	 */
 	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
 	pinctrl-names = "default";
-	samsung,pwm-outputs = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index c7509690131d..0c0bbdbfd85f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -94,7 +94,6 @@
 	 */
 	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
 	pinctrl-names = "default";
-	samsung,pwm-outputs = <0>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index dae0ddc25bdc..2faf88627a48 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -39,7 +39,7 @@
 	 */
 	pinctrl-0 = <&pwm0_out &pwm2_out>;
 	pinctrl-names = "default";
-	samsung,pwm-outputs = <0>;
+	samsung,pwm-outputs = <0>, <2>;
 	status = "okay";
 };
 
-- 
2.1.4
