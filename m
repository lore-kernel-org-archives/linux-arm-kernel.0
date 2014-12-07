From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  7 Dec 2014 20:20:43 +0100
Subject: [PATCH 1/20] mtd: s3c2410: fix misspelling of current function in
 string
In-Reply-To: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1417980062-25151-2-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace a misspelled function name by %s and then __func__.

s3c2410 is the name of the file, but using the exact function name should
make it easier to connect the error message to the code.

This was done using Coccinelle, including the use of Levenshtein distance,
as proposed by Rasmus Villemoes.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch is difficult to summarize, but is available in the cover
letter of this patch series.

 drivers/mtd/nand/s3c2410.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 35aef5e..0a9c41f 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -948,7 +948,7 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
 
 	cpu_type = platform_get_device_id(pdev)->driver_data;
 
-	pr_debug("s3c2410_nand_probe(%p)\n", pdev);
+	pr_debug("%s(%p)\n", __func__, pdev);
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (info == NULL) {
