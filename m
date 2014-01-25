From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 24 Jan 2014 22:32:41 -0300
Subject: [PATCH] clk: sunxi: fix overflow when setting up divided factors
Message-ID: <1390613561-28636-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we are allocating space for two pointers, when we actually
may need to store three of them (two divisors plus the original clock).
Fix this, and change sizeof(type) to sizeof(*var) to keep checkpatch.pl
happy.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Hi Mike,

Is there any chance you can include this oneliner on your second part of
the pull request to Linus?

Cheers,

Emilio

 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 659e4ea..abb6c5a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -875,7 +875,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	if (!clk_data)
 		return;
 
-	clks = kzalloc(SUNXI_DIVS_MAX_QTY * sizeof(struct clk *), GFP_KERNEL);
+	clks = kzalloc((SUNXI_DIVS_MAX_QTY+1) * sizeof(*clks), GFP_KERNEL);
 	if (!clks)
 		goto free_clkdata;
 
-- 
1.8.5.3
