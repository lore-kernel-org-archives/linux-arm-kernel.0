From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 15 Apr 2014 14:58:50 +0530
Subject: [PATCH 2/6] ARM: EXYNOS: Remove exynos_subsys registration
In-Reply-To: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1397554134-11827-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'exynos_subsys' has no users. Remove this code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/exynos.c            |   11 -----------
 arch/arm/plat-samsung/include/plat/cpu.h |    1 -
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index b32a907d021d..eb1a431a894a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -308,17 +308,6 @@ void __init exynos_init_io(void)
 	exynos_map_io();
 }
 
-struct bus_type exynos_subsys = {
-	.name		= "exynos-core",
-	.dev_name	= "exynos-core",
-};
-
-static int __init exynos_core_init(void)
-{
-	return subsys_system_register(&exynos_subsys, NULL);
-}
-core_initcall(exynos_core_init);
-
 static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 5992b8dd9b89..930b4be832cd 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -239,7 +239,6 @@ extern struct bus_type s3c2443_subsys;
 extern struct bus_type s3c6410_subsys;
 extern struct bus_type s5p64x0_subsys;
 extern struct bus_type s5pv210_subsys;
-extern struct bus_type exynos_subsys;
 
 extern void (*s5pc1xx_idle)(void);
 
-- 
1.7.9.5
