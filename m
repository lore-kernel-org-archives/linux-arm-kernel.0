From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Wed, 13 Jul 2016 12:44:41 +0000
Subject: [PATCH -next] drm/mediatek/mtk_mipi_tx: remove redundant dev_err call
 in mtk_mipi_tx_probe()
Message-ID: <1468413881-2588-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
index 1c366f8..b835bba 100644
--- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
+++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
@@ -393,11 +393,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mipi_tx->regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(mipi_tx->regs)) {
-		ret = PTR_ERR(mipi_tx->regs);
-		dev_err(dev, "Failed to get memory resource: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(mipi_tx->regs))
+		return PTR_ERR(mipi_tx->regs);
 
 	ref_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ref_clk)) {
