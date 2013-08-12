From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:43:59 +0530
Subject: [PATCH 1/9] clk: bcm2835: Fix incorrect placement of __initconst
Message-ID: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/clk/clk-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
index 792bc57..5fb4ff5 100644
--- a/drivers/clk/clk-bcm2835.c
+++ b/drivers/clk/clk-bcm2835.c
@@ -23,7 +23,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 
-static const __initconst struct of_device_id clk_match[] = {
+static const struct of_device_id clk_match[] __initconst = {
 	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
 	{ }
 };
-- 
1.7.9.5
