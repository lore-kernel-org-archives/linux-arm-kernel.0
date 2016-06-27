From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jun 2016 13:26:09 +0200
Subject: [RFC PATCH 3/4] cpufreq: exynos: remove big.LITTLE switcher dependency
In-Reply-To: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1467026770-5699-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove no longeer needed workaround for big.LITTLE switcher support.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3646b14..88d4090 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -38,10 +38,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "samsung,exynos4212", },
 	{ .compatible = "samsung,exynos4412", },
 	{ .compatible = "samsung,exynos5250", },
-#ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5420", },
 	{ .compatible = "samsung,exynos5800", },
-#endif
 
 	{ .compatible = "renesas,emev2", },
 	{ .compatible = "renesas,r7s72100", },
-- 
1.9.1
