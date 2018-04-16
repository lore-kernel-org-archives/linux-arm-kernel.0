From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 16 Apr 2018 10:34:30 +0800
Subject: [PATCH] media: rc: mtk-cir: use of_device_get_match_data()
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
Message-ID: <39601fe0c5daf9bcdbb3e44390b671a12d508e00.1523347340.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usage of of_device_get_match_data() reduce the code size a bit.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/media/rc/mtk-cir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index e88eb64..e42efd9 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -299,8 +299,6 @@ static int mtk_ir_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
-	const struct of_device_id *of_id =
-		of_match_device(mtk_ir_match, &pdev->dev);
 	struct resource *res;
 	struct mtk_ir *ir;
 	u32 val;
@@ -312,7 +310,7 @@ static int mtk_ir_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ir->dev = dev;
-	ir->data = of_id->data;
+	ir->data = of_device_get_match_data(dev);
 
 	ir->clk = devm_clk_get(dev, "clk");
 	if (IS_ERR(ir->clk)) {
-- 
1.9.1
