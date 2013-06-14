From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 14 Jun 2013 11:26:18 +0530
Subject: [PATCH] ARM: dts: Enable RTC node for exynos5250
Message-ID: <1371189378-22823-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel dump produced by s3c-rtc driver as reported by
commit 522ccdb6fd0e ("ARM: dts: Disable the RTC by default on exynos5")
are no longer reproducible in latest kernel.

Hence it would be good to re-enable RTC support for EXYNOS5250.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/boot/dts/exynos5250.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0673524..ce4a150 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -188,7 +188,6 @@
 		interrupts = <0 43 0>, <0 44 0>;
 		clocks = <&clock 337>;
 		clock-names = "rtc";
-		status = "disabled";
 	};
 
 	tmu at 10060000 {
-- 
1.7.9.5
