From: leiwen@marvell.com (Lei Wen)
Date: Tue, 22 Jun 2010 22:08:13 +0800
Subject: [PATCH 15/29] pxa3xx_nand: add more attribute that platform
Message-ID: <mailman.133.1280296951.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

could choose from

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c                 |    3 ++-
 arch/arm/mach-mmp/avengers_lite.c            |    3 ++-
 arch/arm/mach-pxa/cm-x300.c                  |    3 +--
 arch/arm/mach-pxa/colibri-pxa3xx.c           |    3 +--
 arch/arm/mach-pxa/littleton.c                |    2 +-
 arch/arm/mach-pxa/mxm8x10.c                  |    3 +--
 arch/arm/mach-pxa/raumfeld.c                 |    3 +--
 arch/arm/mach-pxa/zylonite.c                 |    2 +-
 arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   23 +++++++++++++----------
 drivers/mtd/nand/pxa3xx_nand.c               |   11 +++++++----
 10 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 81ad58d..8d739d1 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -125,7 +125,8 @@ static struct mtd_partition aspenite_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data aspenite_nand_info = {
-	.enable_arbiter	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_NAKED_CMD_EN | PXA3XX_DMA_EN
+				| PXA3XX_ADV_TIME_TUNING | PXA3XX_TWO_CHIP_EN,
 	.parts[0]	= aspenite_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(aspenite_nand_partitions),
 };
diff --git a/arch/arm/mach-mmp/avengers_lite.c
b/arch/arm/mach-mmp/avengers_lite.c
index a828b1c..3a07613 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -77,7 +77,8 @@ static void __init avengers_init_flash(void)
 	avengers_nand_info.nr_parts[0] = ARRAY_SIZE(avengers_nand_partitions_0);
 	avengers_nand_info.parts[1] = avengers_nand_partitions_1;
 	avengers_nand_info.nr_parts[1] = ARRAY_SIZE(avengers_nand_partitions_1);
-	avengers_nand_info.enable_arbiter = 1;
+	avengers_nand_info.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_NAKED_CMD_EN
+		| PXA3XX_DMA_EN | PXA3XX_ADV_TIME_TUNING | PXA3XX_TWO_CHIP_EN;
 	pxa168_add_nand(&avengers_nand_info);
 }

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index ce1f6d3..9f0282b 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -417,8 +417,7 @@ static struct mtd_partition cm_x300_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data cm_x300_nand_info = {
-	.enable_arbiter	= 1,
-	.keep_config	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_DMA_EN | PXA3XX_KEEP_CONFIG,
 	.parts[0]	= cm_x300_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(cm_x300_nand_partitions),
 };
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c
b/arch/arm/mach-pxa/colibri-pxa3xx.c
index b33559c..627b289 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -186,8 +186,7 @@ static struct mtd_partition colibri_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data colibri_nand_info = {
-	.enable_arbiter	= 1,
-	.keep_config	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_DMA_EN | PXA3XX_KEEP_CONFIG,
 	.parts[0]	= colibri_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(colibri_nand_partitions),
 };
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 717cf92..e63451c 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -324,7 +324,7 @@ static struct mtd_partition littleton_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data littleton_nand_info = {
-	.enable_arbiter	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_DMA_EN,
 	.parts[0]	= littleton_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(littleton_nand_partitions),
 };
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index 66c2086..baca736 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -389,8 +389,7 @@ static struct mtd_partition mxm_8x10_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data mxm_8x10_nand_info = {
-	.enable_arbiter	= 1,
-	.keep_config	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_DMA_EN | PXA3XX_KEEP_CONFIG,
 	.parts[0]	= mxm_8x10_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(mxm_8x10_nand_partitions)
 };
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index df75d4d..8761775 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -348,8 +348,7 @@ static struct mtd_partition raumfeld_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data raumfeld_nand_info = {
-	.enable_arbiter	= 1,
-	.keep_config	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_DMA_EN | PXA3XX_KEEP_CONFIG,
 	.parts[0]	= raumfeld_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(raumfeld_nand_partitions),
 };
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 9e5c6cd..5cf3d10 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -355,7 +355,7 @@ static struct mtd_partition zylonite_nand_partitions[] = {
 };

 static struct pxa3xx_nand_platform_data zylonite_nand_info = {
-	.enable_arbiter	= 1,
+	.controller_attrs = PXA3XX_ARBI_EN | PXA3XX_DMA_EN,
 	.parts[0]	= zylonite_nand_partitions,
 	.nr_parts[0]	= ARRAY_SIZE(zylonite_nand_partitions),
 };
diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
index 9b1f9df..ed7d623 100644
--- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
+++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
@@ -49,17 +49,20 @@ struct pxa3xx_nand_flash {
 };

 #define NUM_CHIP_SELECT		(2)
+/* the data flash bus is shared between the Static Memory
+ * Controller and the Data Flash Controller,  the arbiter
+ * controls the ownership of the bus
+ */
+#define PXA3XX_ARBI_EN		(1)
+#define PXA3XX_NAKED_CMD_EN	(1 << 1)
+#define PXA3XX_TWO_CHIP_EN	(1 << 2)
+#define PXA3XX_DMA_EN		(1 << 3)
+/* for newer controller support more precise timing tuning, only
+ * enable such tuning for those platform which support it */
+#define PXA3XX_ADV_TIME_TUNING	(1 << 4)
+#define PXA3XX_KEEP_CONFIG	(1 << 5)
 struct pxa3xx_nand_platform_data {
-
-	/* the data flash bus is shared between the Static Memory
-	 * Controller and the Data Flash Controller,  the arbiter
-	 * controls the ownership of the bus
-	 */
-	int	enable_arbiter;
-
-	/* allow platform code to keep OBM/bootloader defined NFC config */
-	int	keep_config;
-
+	unsigned int				controller_attrs;
 	const struct mtd_partition		*parts[NUM_CHIP_SELECT];
 	unsigned int				nr_parts[NUM_CHIP_SELECT];

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 94df2bd..204c9d6 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -816,7 +816,7 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	else
 		info->row_addr_cycles = 2;

-	ndcr |= (pdata->enable_arbiter) ? NDCR_ND_ARB_EN : 0;
+	ndcr |= (pdata->controller_attrs & PXA3XX_ARBI_EN) ? NDCR_ND_ARB_EN : 0;
 	ndcr |= (info->col_addr_cycles == 2) ? NDCR_RA_START : 0;
 	ndcr |= (f->page_per_block == 64) ? NDCR_PG_PER_BLK : 0;
 	ndcr |= (f->page_size == 2048) ? NDCR_PAGE_SZ : 0;
@@ -947,7 +947,7 @@ static int __devinit pxa3xx_nand_scan(struct mtd_info *mtd)
 	uint64_t chipsize;
 	int i, ret;

-	if (pdata->keep_config) {
+	if (pdata->controller_attrs & PXA3XX_KEEP_CONFIG) {
 		if (pxa3xx_nand_detect_config(nand) == 0)
 			goto KEEP_CONFIG;
 	}
@@ -1215,7 +1215,7 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 	struct mtd_info *mtd;
 	static const char *probes[] = { "cmdlinepart", NULL };
 	struct mtd_partition *parts;
-	int nr_parts, ret, cs, probe_success = 0;
+	int nr_parts, ret, cs, probe_success = 0, cs_to_scan;

 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1223,12 +1223,15 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 		return -ENODEV;
 	}

+	if (!(pdata->controller_attrs & PXA3XX_DMA_EN))
+		use_dma = 0;
 	ret = alloc_nand_resource(pdev);
 	if (ret)
 		return ret;

 	nand = platform_get_drvdata(pdev);
-	for (cs = 0; cs < NUM_CHIP_SELECT; cs++) {
+	cs_to_scan = (pdata->controller_attrs & PXA3XX_TWO_CHIP_EN)? 2 : 1;
+	for (cs = 0; cs < cs_to_scan; cs++) {
 		info = nand->info[cs];
 		mtd = get_mtd_by_info(info);
 		if (pxa3xx_nand_scan(mtd)) {
-- 
1.7.0.4
