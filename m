From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 05 Jul 2016 15:35:07 +0530
Subject: [PATCH] arm64: dts: Fix rtc by providing rtc_src clock
Message-ID: <1467713107-15932-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rtc source clock as exynos7 needs source (32.768KHz) clock
for rtc block. Without this currently rtc driver probe is broken
on this SoC, thats because rtc-s3c driver expect rtc_src clock to
be provided for _s3c6410-rtc_ type rtc controllers.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 03f9cf6..7f48cf0 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 #include "exynos7.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/samsung,s2mps11.h>
 
 / {
 	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
@@ -44,6 +45,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clock_ccore PCLK_RTC>, <&s2mps15_osc S2MPS11_CLK_AP>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &watchdog {
-- 
1.7.10.4
