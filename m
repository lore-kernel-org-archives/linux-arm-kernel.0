From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 28 Oct 2014 15:20:32 +0530
Subject: [PATCH] ARM: EXYNOS: fix typo in static struct name
 "exynos5_list_diable_wfi_wfe"
Message-ID: <1414489832-28011-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a typo in struct named as "exynos5_list_diable_wfi_wfe"
by making it "exynos5_list_disable_wfi_wfe" which is more meaningful.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pmu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index cfc62e8..e5e1846 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -330,7 +330,7 @@ static unsigned int const exynos5_list_both_cnt_feed[] = {
 	EXYNOS5_TOP_PWR_SYSMEM_OPTION,
 };
 
-static unsigned int const exynos5_list_diable_wfi_wfe[] = {
+static unsigned int const exynos5_list_disable_wfi_wfe[] = {
 	EXYNOS5_ARM_CORE1_OPTION,
 	EXYNOS5_FSYS_ARM_OPTION,
 	EXYNOS5_ISP_ARM_OPTION,
@@ -361,11 +361,11 @@ static void exynos5_init_pmu(void)
 	/*
 	 * Disable WFI/WFE on XXX_OPTION
 	 */
-	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_diable_wfi_wfe) ; i++) {
-		tmp = pmu_raw_readl(exynos5_list_diable_wfi_wfe[i]);
+	for (i = 0 ; i < ARRAY_SIZE(exynos5_list_disable_wfi_wfe) ; i++) {
+		tmp = pmu_raw_readl(exynos5_list_disable_wfi_wfe[i]);
 		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
 			 EXYNOS5_OPTION_USE_STANDBYWFI);
-		pmu_raw_writel(tmp, exynos5_list_diable_wfi_wfe[i]);
+		pmu_raw_writel(tmp, exynos5_list_disable_wfi_wfe[i]);
 	}
 }
 
-- 
1.7.9.5
