From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Mar 2015 12:08:40 +0100
Subject: [PATCH v4 2/3] ARM: EXYNOS: Constify exynos_pm_data array
In-Reply-To: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
References: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1426072121-6822-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'exynos5420_pm_data' is not modified and can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---

Notes:
    Changes since v3:
    1. The 'of_device_id' was already constifyied by Uwe Kleine-K?nig.
    
    Changes since v2:
    1. Add Pankaj's reviewed-by.
    
    Changes since v1:
    1. New patch.

 arch/arm/mach-exynos/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 2fefb7073083..d42fb1cd202d 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -576,7 +576,7 @@ static const struct exynos_pm_data exynos5250_pm_data = {
 	.cpu_suspend	= exynos_cpu_suspend,
 };
 
-static struct exynos_pm_data exynos5420_pm_data = {
+static const struct exynos_pm_data exynos5420_pm_data = {
 	.wkup_irq	= exynos5250_wkup_irq,
 	.wake_disable_mask = (0x7F << 7) | (0x1F << 1),
 	.release_ret_regs = exynos5420_release_ret_regs,
-- 
1.9.1
