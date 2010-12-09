From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Thu, 9 Dec 2010 11:22:50 +0200
Subject: [PATCH 2/2] OMAP2/3: OneNAND: add 104MHz support
Message-ID: <mailman.71.1292960732.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPMC timings for 104MHz OneNAND.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    9 +++++++++
 drivers/mtd/onenand/omap2.c        |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 1db606c..3a7d25f 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -173,6 +173,15 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	}
 
 	switch (freq) {
+	case 104:
+		min_gpmc_clk_period = 9600; /* 104 MHz */
+		t_ces   = 3;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 3;
+		t_aavdh = 6;
+		t_rdyo  = 9;
+		break;
 	case 83:
 		min_gpmc_clk_period = 12000; /* 83 MHz */
 		t_ces   = 5;
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 9f322f1..d0894ca 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -721,6 +721,9 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	case 3:
 		c->freq = 83;
 		break;
+	case 4:
+		c->freq = 104;
+		break;
 	}
 
 #ifdef CONFIG_MTD_PARTITIONS
-- 
1.7.0.4
