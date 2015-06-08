From: eric@anholt.net (Eric Anholt)
Date: Mon,  8 Jun 2015 16:58:58 -0700
Subject: [PATCH v3 5/7] ARM: bcm2835: Drop the fixed sys_pclk.
In-Reply-To: <1433807940-15328-1-git-send-email-eric@anholt.net>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
Message-ID: <1433807940-15328-5-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing uses it, and I can't find any evidence that anything ever has.

Signed-off-by: Eric Anholt <eric@anholt.net>
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
