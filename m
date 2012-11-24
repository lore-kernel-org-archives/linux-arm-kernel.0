From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 24 Nov 2012 15:23:30 +0530
Subject: [PATCH] ARM: Exynos5: fix clock initialization for exynos5250
Message-ID: <1353750810-21953-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine compatible value cannot be checked in exynos5_dt_map_io function
since the tree is not unflattened yet. Fix this by using soc_is_exynos5250
macro.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 77010f8..845d8e2 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -117,7 +117,7 @@ static void __init exynos5_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
 
-	if (of_machine_is_compatible("samsung,exynos5250"))
+	if (soc_is_exynos5250())
 		s3c24xx_init_clocks(24000000);
 }
 
-- 
1.6.6.rc2
