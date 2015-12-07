From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 07 Dec 2015 19:18:20 +0100
Subject: [PATCH v4 8/8] ARM: Exynos: use generic cpufreq driver for
 Exynos5422/5800
In-Reply-To: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1449512300-17230-9-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic cpufreq-dt driver
for Exynos5422/5800.

Changes by Bartlomiej:
- split Exynos5800 support from the original patch
- disable cpufreq if big.LITTLE switcher support is enabled
- switch to using cpufreq-dt driver

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 7a89c9d..cec8aeb 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -232,6 +232,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 #ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos5800", .data = "cpufreq-dt" },
 #endif
 	{ /* sentinel */ }
 };
-- 
1.9.1
