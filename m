From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 14:44:32 +0200
Subject: [PATCH 5/5] clk: sunxi: sun9i-mmc: Fix module autoload for OF
 platform driver
Message-ID: <20150828124432.GA26670@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/clk/sunxi/clk-sun9i-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index 710c273..7618b13 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -203,6 +203,7 @@ static const struct of_device_id sun9i_a80_mmc_config_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun9i-a80-mmc-config-clk" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sun9i_a80_mmc_config_clk_dt_ids);
 
 static struct platform_driver sun9i_a80_mmc_config_clk_driver = {
 	.driver = {
-- 
2.4.6
