From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 30 Mar 2015 17:21:29 +0200
Subject: [PATCH] ARM: dts: Use define for s3c-rtc clock id
Message-ID: <1427728889-29158-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a define instead of raw number as a ID for "rtc_src" clock.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Patch depends on new file "dt-bindings/clock/samsung,s2mps11.h" from:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg43136.html
---
 arch/arm/boot/dts/exynos3250-rinato.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 3905824cac58..d2cbc95364de 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -16,6 +16,7 @@
 #include "exynos3250.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/samsung,s2mps11.h>
 
 / {
 	model = "Samsung Rinato board";
@@ -605,7 +606,7 @@
 };
 
 &rtc {
-	clocks = <&cmu CLK_RTC>, <&s2mps14_osc 0>;
+	clocks = <&cmu CLK_RTC>, <&s2mps14_osc S2MPS11_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
 	status = "okay";
 };
-- 
1.9.1
