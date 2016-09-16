From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Sep 2016 10:33:45 +0200
Subject: [PATCH] ARM: dts: exynos: Remove "simple-bus" compatible from fimc-is
 node
Message-ID: <1474014825-28969-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "simple-bus" compatible was originally added for fimc-is only
to ensure the child devices instantiation.  The child devices are
now being created by the parent device driver so remove the
"simple-bus" compatible.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index c452499..e8d0678 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -147,7 +147,7 @@
 		};
 
 		fimc_is: fimc-is at 12000000 {
-			compatible = "samsung,exynos4212-fimc-is", "simple-bus";
+			compatible = "samsung,exynos4212-fimc-is";
 			reg = <0x12000000 0x260000>;
 			interrupts = <0 90 0>, <0 95 0>;
 			power-domains = <&pd_isp>;
-- 
1.9.1
