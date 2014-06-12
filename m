From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Jun 2014 10:00:02 +0530
Subject: [PATCH] ARM: exynos: Fix warning by constifying 'reg' in
 exynos_fdt_map_chipid()
Message-ID: <3c6b5c1f19fcbee39a3f0a0bd2c9ddd811d5e619.1402547301.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos_fdt_map_chipid() was recently added with: cbf08b9 (ARM: EXYNOS:
Consolidate exynos4 and exynos5 machine files) and generates this warning:

arch/arm/mach-exynos/exynos.c: In function ?exynos_fdt_map_chipid?:
arch/arm/mach-exynos/exynos.c:208:6: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]

Constify 'reg' to fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 90aab4d..b71598a 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -198,7 +198,7 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
 					int depth, void *data)
 {
 	struct map_desc iodesc;
-	__be32 *reg;
+	const __be32 *reg;
 	int len;
 
 	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
-- 
2.0.0.rc2
