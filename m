From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Tue, 05 Jul 2016 20:40:17 +0900
Subject: [PATCH] memory: samsung: exynos-srom: fix wrong count of registers
Message-ID: <1467718817-19239-1-git-send-email-sw0312.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes wrong count of array for srom registers from probe
function.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 drivers/memory/samsung/exynos-srom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 96756fb..c66d2bd 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -134,7 +134,7 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, srom);
 
 	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
-			sizeof(exynos_srom_offsets));
+			ARRAY_SIZE(exynos_srom_offsets));
 	if (!srom->reg_offset) {
 		iounmap(srom->reg_base);
 		return -ENOMEM;
-- 
1.7.9.5
