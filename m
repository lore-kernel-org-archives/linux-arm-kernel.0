From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 27 Jan 2015 15:10:11 +0100
Subject: [PATCH 4/9] mtd: pxa3xx_nand: add a default chunk size
In-Reply-To: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1422367816-4257-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a default chunk size of 512 in the pxa3xx nand driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 782ae24d6b7d..b2783b1f663c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1430,6 +1430,9 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
 		goto KEEP_CONFIG;
 
+	/* Set a default chunk size */
+	info->chunk_size = 512;
+
 	ret = pxa3xx_nand_sensing(info);
 	if (ret) {
 		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",
-- 
2.2.2
