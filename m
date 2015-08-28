From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 14:43:54 +0200
Subject: [PATCH 3/5] clk: sunxi: sun6i-ar100: Fix module autoload for OF
 platform driver
Message-ID: <20150828124354.GA26610@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/clk/sunxi/clk-sun6i-ar100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index 63cf149..40828fb 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -219,6 +219,7 @@ static const struct of_device_id sun6i_a31_ar100_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-ar100-clk" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sun6i_a31_ar100_clk_dt_ids);
 
 static struct platform_driver sun6i_a31_ar100_clk_driver = {
 	.driver = {
-- 
2.4.6
