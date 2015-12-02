From: ben@smart-cactus.org (Ben Gamari)
Date: Wed,  2 Dec 2015 22:19:23 +0100
Subject: [PATCH 08/12] ARM: Exynos: use generic cpufreq driver for Exynos5800
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Message-ID: <1449091167-20758-9-git-send-email-ben@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic arm_big_little_dt
cpufreq driver for Exynos5800.

Changes by Bartlomiej:
- split Exynos5800 support from the original patch
- disable cpufreq if big.LITTLE switcher support is enabled

Changes by Ben Gamari:
- rebase

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 818e6a0..9289412 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -236,6 +236,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	 */
 #ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
+	{ .compatible = "samsung,exynos5800", .data = "arm-bL-cpufreq-dt" },
 #endif
 	{ /* sentinel */ }
 };
-- 
2.6.2
