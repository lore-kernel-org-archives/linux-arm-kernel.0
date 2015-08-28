From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 28 Aug 2015 14:44:14 +0200
Subject: [PATCH 4/5] clk: sunxi: sun8i-apb0: Fix module autoload for OF
 platform driver
Message-ID: <20150828124414.GA26661@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/clk/sunxi/clk-sun8i-apb0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index 155d002..7ae5d2c 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -52,6 +52,7 @@ static const struct of_device_id sun8i_a23_apb0_clk_dt_ids[] = {
 	{ .compatible = "allwinner,sun8i-a23-apb0-clk" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, sun8i_a23_apb0_clk_dt_ids);
 
 static struct platform_driver sun8i_a23_apb0_clk_driver = {
 	.driver = {
-- 
2.4.6
