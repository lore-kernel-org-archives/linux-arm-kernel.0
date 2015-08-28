From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 14:43:14 +0200
Subject: [PATCH 1/5] clk: sunxi: sun6i-apb0: Fix module autoload for OF
 platform driver
Message-ID: <20150828124314.GA26550@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/clk/sunxi/clk-sun6i-apb0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0.c b/drivers/clk/sunxi/clk-sun6i-apb0.c
index 7076360..e703e18 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0.c
@@ -61,6 +61,7 @@ static const struct of_device_id sun6i_a31_apb0_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-apb0-clk" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sun6i_a31_apb0_clk_dt_ids);
 
 static struct platform_driver sun6i_a31_apb0_clk_driver = {
 	.driver = {
-- 
2.4.6
