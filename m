From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Thu, 1 Nov 2018 09:20:20 +0200
Subject: [PATCH v2 5/8] clk: clk-hi655x: Free of_provider at remove
In-Reply-To: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <3b6742f090502f1f75cba283bc6d29e8ccbd92d3.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-hi655x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hi655x.c b/drivers/clk/clk-hi655x.c
index 403a0188634a..394d0109104d 100644
--- a/drivers/clk/clk-hi655x.c
+++ b/drivers/clk/clk-hi655x.c
@@ -107,8 +107,8 @@ static int hi655x_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &hi655x_clk->clk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+				of_clk_hw_simple_get, &hi655x_clk->clk_hw);
 }
 
 static struct platform_driver hi655x_clk_driver = {
-- 
2.14.3
