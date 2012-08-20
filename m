From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 20 Aug 2012 13:49:38 +0800
Subject: [PATCH 2/3] mtd: nand: append missing parameter and value
In-Reply-To: <1345441779-22632-1-git-send-email-haojian.zhuang@gmail.com>
References: <1345441779-22632-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1345441779-22632-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 9c08691..616993a 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -1035,7 +1035,7 @@ static int alloc_nand_resource(struct platform_device *pdev)
 	struct pxa3xx_nand_platform_data *pdata;
 	struct pxa3xx_nand_info *info;
 	struct pxa3xx_nand_host *host;
-	struct nand_chip *chip;
+	struct nand_chip *chip = NULL;
 	struct mtd_info *mtd;
 	struct resource *r;
 	int ret, irq, cs;
@@ -1245,7 +1245,7 @@ static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 	return 0;
 }
 #else
-static inline int pxa3xx_nand_probe_dt(struct platform_device *)
+static inline int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 {
 	return 0;
 }
-- 
1.7.9.5
