From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Jul 2015 09:42:41 +0900
Subject: [PATCH v6 3/3] ARM: exynos: Add exynos3250 compatible to use generic
 cpufreq driver
In-Reply-To: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
References: <1435797761-3339-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1435797761-3339-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add exynos3250 compatible string to exynos_cpufreq_matches
for supporting generic cpufreq driver on Exynos3250.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4015ec369ae5..77ac0216ddc4 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -225,6 +225,7 @@ static void __init exynos_init_irq(void)
 }
 
 static const struct of_device_id exynos_cpufreq_matches[] = {
+	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 	{ /* sentinel */ }
-- 
1.8.5.5
