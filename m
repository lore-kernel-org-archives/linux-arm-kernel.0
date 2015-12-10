From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 10 Dec 2015 17:58:46 +0100
Subject: [PATCH v5 4/7] ARM: Exynos: use generic cpufreq driver for Exynos5420
In-Reply-To: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449766729-435-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new CPU clock type allows the use of cpufreq-dt driver
for Exynos5420.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 1c47aee..7a89c9d 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -230,6 +230,9 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
+#ifndef CONFIG_BL_SWITCHER
+	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
+#endif
 	{ /* sentinel */ }
 };
 
-- 
1.9.1
