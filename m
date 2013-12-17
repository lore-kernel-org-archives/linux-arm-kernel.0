From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 17 Dec 2013 15:36:44 +0200
Subject: [PATCH v4 3/9] mtd: nand: davinci: check required ti,
 davinci-chipselect property
In-Reply-To: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1387287404-19767-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The property "ti,davinci-chipselect" is required. So we have to check
if it is set.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Taras Kondratiuk <taras@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 4577fb4..9eea269 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -545,6 +545,9 @@ static struct davinci_nand_pdata
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-chipselect", &prop))
 			pdev->id = prop;
+		else
+			return ERR_PTR(-EINVAL);
+
 		if (!of_property_read_u32(pdev->dev.of_node,
 			"ti,davinci-mask-ale", &prop))
 			pdata->mask_ale = prop;
-- 
1.7.9.5
