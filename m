From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 03 Feb 2015 12:06:40 +0100
Subject: [PATCH v2 2/3] ARM: EXYNOS: Constify exynos_pm_data and of_device_id
 array
In-Reply-To: <1422961601-7087-1-git-send-email-k.kozlowski@samsung.com>
References: <1422961601-7087-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1422961601-7087-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'exynos5420_pm_data' and of_device_id array are not modified and can
be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---
Changes since v1:
1. New patch.
---
 arch/arm/mach-exynos/suspend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 77cc39bdad47..e6c961126087 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -572,7 +572,7 @@ static const struct exynos_pm_data exynos5250_pm_data = {
 	.cpu_suspend	= exynos_cpu_suspend,
 };
 
-static struct exynos_pm_data exynos5420_pm_data = {
+static const struct exynos_pm_data exynos5420_pm_data = {
 	.wkup_irq	= exynos5250_wkup_irq,
 	.wake_disable_mask = (0x7F << 7) | (0x1F << 1),
 	.release_ret_regs = exynos5420_release_ret_regs,
@@ -583,7 +583,7 @@ static struct exynos_pm_data exynos5420_pm_data = {
 	.cpu_suspend	= exynos5420_cpu_suspend,
 };
 
-static struct of_device_id exynos_pmu_of_device_ids[] = {
+static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	{
 		.compatible = "samsung,exynos3250-pmu",
 		.data = &exynos3250_pm_data,
-- 
1.9.1
