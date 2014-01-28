From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Tue, 28 Jan 2014 15:09:47 +0900
Subject: [PATCH] clk: remove unnecessary substitution
Message-ID: <1390889387-24137-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2b38dc9..d97b313 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1637,7 +1637,7 @@ static struct clk *__clk_init_parent(struct clk *clk)
 
 	if (clk->num_parents == 1) {
 		if (IS_ERR_OR_NULL(clk->parent))
-			ret = clk->parent = __clk_lookup(clk->parent_names[0]);
+			clk->parent = __clk_lookup(clk->parent_names[0]);
 		ret = clk->parent;
 		goto out;
 	}
-- 
1.8.3.2
