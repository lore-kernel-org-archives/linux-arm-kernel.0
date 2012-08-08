From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:22 +0200
Subject: [PATCH 05/11] ARM: exynos: exynos_pm_add_dev_to_genpd may be unused
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

exynos_pm_add_dev_to_genpd is used if one or more out of a large
number of Kconfig symbols are enabled. However the new
exynos_defconfig selects none of those, so the function becomes
unused. Marking it so lets the compiler automatically discard
it.

Without this patch, building exynos_defconfig results in:

arch/arm/mach-exynos/pm_domains.c:118:123: warning: 'exynos_pm_add_dev_to_genpd' defined but not used [-Wunused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 373c3c0..c0bc83a 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -115,7 +115,7 @@ static __init int exynos_pm_dt_parse_domains(void)
 }
 #endif /* CONFIG_OF */
 
-static __init void exynos_pm_add_dev_to_genpd(struct platform_device *pdev,
+static __init __maybe_unused void exynos_pm_add_dev_to_genpd(struct platform_device *pdev,
 						struct exynos_pm_domain *pd)
 {
 	if (pdev->dev.bus) {
-- 
1.7.10
