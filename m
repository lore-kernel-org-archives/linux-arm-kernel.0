From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 10 Jan 2018 12:02:46 +0800
Subject: [PATCH] hw_random: mediatek: Setup default RNG quality
Message-ID: <134f98ae3270cc6040121cf75d50c916adfe58dc.1515556571.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

When hw_random device's quality is non-zero, it will automatically fill
the kernel's entropy pool at boot.  For the purpose, one conservative
quality value is being picked up as the default value.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/char/hw_random/mtk-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index 8da7bcf..7f99cd5 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -135,6 +135,7 @@ static int mtk_rng_probe(struct platform_device *pdev)
 #endif
 	priv->rng.read = mtk_rng_read;
 	priv->rng.priv = (unsigned long)&pdev->dev;
+	priv->rng.quality = 900;
 
 	priv->clk = devm_clk_get(&pdev->dev, "rng");
 	if (IS_ERR(priv->clk)) {
-- 
2.7.4
