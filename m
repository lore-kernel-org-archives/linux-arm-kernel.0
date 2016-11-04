From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  4 Nov 2016 19:49:20 +0900
Subject: [PATCH 1/2] i2c: uniphier: rename jump label to follow coding style
 guideline
Message-ID: <1478256561-7709-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/CodingStyle recommends to use label names which say
what the goto does or why the goto exists.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index cc80bb2..abc6770 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -373,7 +373,7 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 	if (!clk_rate) {
 		dev_err(dev, "input clock rate should not be zero\n");
 		ret = -EINVAL;
-		goto err;
+		goto disable_clk;
 	}
 
 	init_completion(&priv->comp);
@@ -392,11 +392,11 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 			       priv);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", irq);
-		goto err;
+		goto disable_clk;
 	}
 
 	ret = i2c_add_adapter(&priv->adap);
-err:
+disable_clk:
 	if (ret)
 		clk_disable_unprepare(priv->clk);
 
-- 
1.9.1
