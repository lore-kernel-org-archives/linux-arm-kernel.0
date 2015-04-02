From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Apr 2015 13:03:07 +0200
Subject: [PATCH 1/2] ARM: dts: Use define for s3c-rtc clock id
Message-ID: <1427972588-6573-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a define instead of raw number as a ID for "rtc_src" clock.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Patch depends on new file "dt-bindings/clock/samsung,s2mps11.h" from:
1. ARM: dts: Add bindings for 32kHz clocks from s2mps11
   http://www.spinics.net/lists/linux-samsung-soc/msg43345.html
---
 arch/arm/boot/dts/exynos3250-monk.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 1d483c1c8b48..a5863acc5fff 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -16,6 +16,7 @@
 #include "exynos3250.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/samsung,s2mps11.h>
 
 / {
 	model = "Samsung Monk board";
@@ -432,7 +433,7 @@
 };
 
 &rtc {
-	clocks = <&cmu CLK_RTC>, <&s2mps14_osc 0>;
+	clocks = <&cmu CLK_RTC>, <&s2mps14_osc S2MPS11_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
 	status = "okay";
 };
-- 
1.9.1
