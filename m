From: eric@anholt.net (Eric Anholt)
Date: Mon, 20 Jul 2015 12:33:04 -0700
Subject: [PATCH v4 5/8] clk: bcm2835: Drop the fixed sys_pclk.
In-Reply-To: <1437420787-32137-1-git-send-email-eric@anholt.net>
References: <1437420787-32137-1-git-send-email-eric@anholt.net>
Message-ID: <1437420787-32137-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing uses it, and I can't find any evidence that anything ever has.
Its role is now filled by the core clock in the firmware driver.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/clk/clk-bcm2835.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
index 6b950ca..dd295e4 100644
--- a/drivers/clk/clk-bcm2835.c
+++ b/drivers/clk/clk-bcm2835.c
@@ -32,11 +32,6 @@ void __init bcm2835_init_clocks(void)
 	struct clk *clk;
 	int ret;
 
-	clk = clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT,
-					250000000);
-	if (IS_ERR(clk))
-		pr_err("sys_pclk not registered\n");
-
 	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
 					126000000);
 	if (IS_ERR(clk))
-- 
2.1.4
