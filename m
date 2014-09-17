From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 17 Sep 2014 13:50:33 +0200
Subject: [PATCH 2/2] ARM: dts: Add rtc_src clk for s3c-rtc on exynos5250-snow
In-Reply-To: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410954633-27025-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 546b117fdf17 ("rtc: s3c: add support for RTC of Exynos3250 SoC")
added an "rtc_src" DT property for the Samsung's S3C Real Time Clock
controller that specifies the 32.768 kHz clock that uses the RTC as its
source clock. In the case of the Exynos5250 based Snow board, the Maxim
77686 32kHz AP clock is used as the source clock.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index e51fcef..56eec56 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/maxim,max77686.h>
 #include "exynos5250.dtsi"
 
 / {
@@ -29,6 +30,8 @@
 
 	rtc at 101E0000 {
 		status = "okay";
+		clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
+		clock-names = "rtc", "rtc_src";
 	};
 
 	pinctrl at 11400000 {
@@ -350,7 +353,7 @@
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <378000>;
 
-	max77686 at 09 {
+	max77686: max77686 at 09 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx3>;
 		interrupts = <2 0>;
-- 
2.1.0
