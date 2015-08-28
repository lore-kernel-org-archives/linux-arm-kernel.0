From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 14:43:33 +0200
Subject: [PATCH 2/5] clk: sunxi: sun6i-apb0-gates: Fix module autoload for OF
 platform driver
Message-ID: <20150828124333.GA26601@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 64f3e46..23d042a 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -34,6 +34,7 @@ static const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun8i-a23-apb0-gates-clk", .data = &sun8i_a23_apb0_gates },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sun6i_a31_apb0_gates_clk_dt_ids);
 
 static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 {
-- 
2.4.6
