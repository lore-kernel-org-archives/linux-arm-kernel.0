From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sat, 08 Nov 2014 18:46:38 +0530
Subject: [PATCH v2 3/6] drivers: soc: samsung: Fix a spelling mistake
In-Reply-To: <1415452601-13078-1-git-send-email-amit.daniel@samsung.com>
References: <1415452601-13078-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1415452601-13078-4-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches changes the name of exynos5_list_diable_wfi_wfe to
exynos5_list_disable_wfi_wfe.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 35774e8..3832cda 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -361,7 +361,7 @@ static unsigned int const exynos5_list_both_cnt_feed[] = {
 	EXYNOS5_TOP_PWR_SYSMEM_OPTION,
 };
 
-static unsigned int const exynos5_list_diable_wfi_wfe[] = {
+static unsigned int const exynos5_list_disable_wfi_wfe[] = {
 	EXYNOS5_ARM_CORE1_OPTION,
 	EXYNOS5_FSYS_ARM_OPTION,
 	EXYNOS5_ISP_ARM_OPTION,
@@ -392,11 +392,11 @@ static void exynos5_powerdown_conf(enum sys_powerdown mode)
 	/*
 	 * Disable WFI/WFE on XXX_OPTION
 	 */
-	for (i = 0; i < ARRAY_SIZE(exynos5_list_diable_wfi_wfe); i++) {
-		tmp = pmu_raw_readl(exynos5_list_diable_wfi_wfe[i]);
+	for (i = 0; i < ARRAY_SIZE(exynos5_list_disable_wfi_wfe); i++) {
+		tmp = pmu_raw_readl(exynos5_list_disable_wfi_wfe[i]);
 		tmp &= ~(EXYNOS5_OPTION_USE_STANDBYWFE |
 			 EXYNOS5_OPTION_USE_STANDBYWFI);
-		pmu_raw_writel(tmp, exynos5_list_diable_wfi_wfe[i]);
+		pmu_raw_writel(tmp, exynos5_list_disable_wfi_wfe[i]);
 	}
 }
 
-- 
1.7.9.5
