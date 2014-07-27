From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Jul 2014 14:22:05 +0200
Subject: [PATCH 3/3] ARM: EXYNOS: Add support for Exynos5410 PMU
In-Reply-To: <1406463725-4208-1-git-send-email-afaerber@suse.de>
References: <1406463725-4208-1-git-send-email-afaerber@suse.de>
Message-ID: <1406463725-4208-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos initialization code now relies on obtaining the PMU address,
so add the new 5410 value to the list of compatible string matches.
This unbreaks booting on 5410 based boards.

Fixes: fce9e5bb2526 ("ARM: EXYNOS: Add support for mapping PMU base address via DT")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index df41bd190dfb..a83a312299a3 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -252,6 +252,7 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
 	{ .compatible = "samsung,exynos4212-pmu" },
 	{ .compatible = "samsung,exynos4412-pmu" },
 	{ .compatible = "samsung,exynos5250-pmu" },
+	{ .compatible = "samsung,exynos5410-pmu" },
 	{ .compatible = "samsung,exynos5420-pmu" },
 	{ /*sentinel*/ },
 };
-- 
1.9.3
