From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 13 Sep 2015 18:32:16 +0900
Subject: [PATCH v2] ARM: dts: Fix LEDs on exynos5422-odroidxu3
Message-ID: <1442136736-28672-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LEDs on Odroid XU3 family boards could not properly probe because PWM
outputs were reduced only to PWM for fan. Fix it for Odroid XU3 and
XU3-Lite boards by switching to usage of all 4 outputs (although the PWM
for MIPI probably is redundant because board does not have MIPI
connector available).

This fixes warnings on dmesg:
[    4.838712] samsung-pwm 12dd0000.pwm: tried to request PWM channel 1 without output
[    4.838725] leds_pwm pwmleds: unable to request PWM for green:mmc0: -22
[    4.838767] leds_pwm: probe of pwmleds failed with error -22

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

---

Changes since v1:
1. Do not rebase on patchset adding support for Odroid XU4 board. Rebase
   just on current next.
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index dd8bc86d9de4..90d298dce851 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -473,7 +473,6 @@
 	 */
 	pinctrl-0 = <&pwm0_out &pwm1_out &pwm2_out &pwm3_out>;
 	pinctrl-names = "default";
-	samsung,pwm-outputs = <0>;
 	status = "okay";
 };
 
-- 
2.1.4
