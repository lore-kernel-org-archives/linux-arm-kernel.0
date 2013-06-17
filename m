From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:18 +0200
Subject: [PATCH v2 33/38] thermal: exynos: Remove check for SOC_EXYNOS4412
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-34-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since SOC_EXYNOS4412 Kconfig symbol has been removed, it is enough to
check for SOC_EXYNOS4212 for both SoCs from Exynos4x12 series.

Cc: linux-pm at vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/exynos_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 4cbe3ee..f88a2ad 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -817,8 +817,7 @@ static struct exynos_tmu_platform_data const exynos4210_default_tmu_data = {
 #define EXYNOS4210_TMU_DRV_DATA (NULL)
 #endif
 
-#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) || \
-	defined(CONFIG_SOC_EXYNOS4212)
+#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4212)
 static struct exynos_tmu_platform_data const exynos_default_tmu_data = {
 	.threshold_falling = 10,
 	.trigger_levels[0] = 85,
-- 
1.8.2.1
