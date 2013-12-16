From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 16 Dec 2013 22:25:27 +0100
Subject: [PATCH] clk: at91: fix pmc_clk_ids data type attriubte
Message-ID: <1387229127-7605-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix pmc_clk_ids data type attribute (__initdata -> __initconst).

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/clk/at91/pmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 7b9db60..4c03eda 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -228,7 +228,7 @@ out_free_pmc:
 	return NULL;
 }
 
-static const struct of_device_id pmc_clk_ids[] __initdata = {
+static const struct of_device_id pmc_clk_ids[] __initconst = {
 	/* Main clock */
 	{
 		.compatible = "atmel,at91rm9200-clk-main",
-- 
1.7.9.5
