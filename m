From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 21 Mar 2014 13:39:20 +0100
Subject: [PATCH 2/2] clk: s2mps11: Use of_get_child_by_name
In-Reply-To: <1395404297-12133-1-git-send-email-k.kozlowski@samsung.com>
References: <1395404297-12133-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1395405560-11733-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_node_by_name() walks over all nodes and can thus walk outside of
the parent node. Use of_get_child_by_name() instead.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-s2mps11.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 27c83e45eaed..6de6a970c086 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -132,7 +132,7 @@ static struct device_node *s2mps11_clk_parse_dt(struct platform_device *pdev)
 	if (!iodev->dev->of_node)
 		return ERR_PTR(-EINVAL);
 
-	clk_np = of_find_node_by_name(iodev->dev->of_node, "clocks");
+	clk_np = of_get_child_by_name(iodev->dev->of_node, "clocks");
 	if (!clk_np) {
 		dev_err(&pdev->dev, "could not find clock sub-node\n");
 		return ERR_PTR(-EINVAL);
-- 
1.7.9.5
