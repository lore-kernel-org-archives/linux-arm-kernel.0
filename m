From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 29 Jun 2015 19:26:11 +0200
Subject: [PATCH v2 3/4] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos5250
In-Reply-To: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
References: <1435598772-21708-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1435598772-21708-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos5250 to using generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5250 support from the original patch

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 5f8ddcd..4015ec3 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -226,6 +226,7 @@ static void __init exynos_init_irq(void)
 
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 	{ /* sentinel */ }
 };
 
-- 
1.9.1
