From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 21 Sep 2017 16:26:57 +0800
Subject: [PATCH v4 7/7] soc: mediatek: pwrap: fixup warnings from coding style
In-Reply-To: <cover.1505980364.git.sean.wang@mediatek.com>
References: <cover.1505980364.git.sean.wang@mediatek.com>
Message-ID: <378110a7db137dd89b63b9f7bfd4ec6da2c2395a.1505980364.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

fixup those warnings such as lines over 80 words and parenthesis
alignment which would be complained by checkpatch.pl.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 567d038..2d13cf6 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1057,7 +1057,8 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	/* wait for cipher data ready at PMIC */
 	ret = pwrap_wait_for_state(wrp, pwrap_is_pmic_cipher_ready);
 	if (ret) {
-		dev_err(wrp->dev, "timeout waiting for cipher data ready at PMIC\n");
+		dev_err(wrp->dev,
+			"timeout waiting for cipher data ready at PMIC\n");
 		return ret;
 	}
 
@@ -1458,23 +1459,27 @@ static int pwrap_probe(struct platform_device *pdev)
 		if (IS_ERR(wrp->bridge_base))
 			return PTR_ERR(wrp->bridge_base);
 
-		wrp->rstc_bridge = devm_reset_control_get(wrp->dev, "pwrap-bridge");
+		wrp->rstc_bridge = devm_reset_control_get(wrp->dev,
+							  "pwrap-bridge");
 		if (IS_ERR(wrp->rstc_bridge)) {
 			ret = PTR_ERR(wrp->rstc_bridge);
-			dev_dbg(wrp->dev, "cannot get pwrap-bridge reset: %d\n", ret);
+			dev_dbg(wrp->dev,
+				"cannot get pwrap-bridge reset: %d\n", ret);
 			return ret;
 		}
 	}
 
 	wrp->clk_spi = devm_clk_get(wrp->dev, "spi");
 	if (IS_ERR(wrp->clk_spi)) {
-		dev_dbg(wrp->dev, "failed to get clock: %ld\n", PTR_ERR(wrp->clk_spi));
+		dev_dbg(wrp->dev, "failed to get clock: %ld\n",
+			PTR_ERR(wrp->clk_spi));
 		return PTR_ERR(wrp->clk_spi);
 	}
 
 	wrp->clk_wrap = devm_clk_get(wrp->dev, "wrap");
 	if (IS_ERR(wrp->clk_wrap)) {
-		dev_dbg(wrp->dev, "failed to get clock: %ld\n", PTR_ERR(wrp->clk_wrap));
+		dev_dbg(wrp->dev, "failed to get clock: %ld\n",
+			PTR_ERR(wrp->clk_wrap));
 		return PTR_ERR(wrp->clk_wrap);
 	}
 
@@ -1519,8 +1524,9 @@ static int pwrap_probe(struct platform_device *pdev)
 	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
 
 	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt, IRQF_TRIGGER_HIGH,
-			"mt-pmic-pwrap", wrp);
+	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
+			       IRQF_TRIGGER_HIGH,
+			       "mt-pmic-pwrap", wrp);
 	if (ret)
 		goto err_out2;
 
-- 
2.7.4
