From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 22 Dec 2017 17:47:21 +0800
Subject: [PATCH 1/1] clk: remove invalid __clk_set_parent comment in
 __clk_core_init
Message-ID: <1513936041-13010-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those comments are invalid anymore. So remove them.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d6e2d5c..4675adf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2927,10 +2927,6 @@ static int __clk_core_init(struct clk_core *core)
 		struct clk_core *parent = __clk_init_parent(orphan);
 		unsigned long flags;
 
-		/*
-		 * we could call __clk_set_parent, but that would result in a
-		 * redundant call to the .set_rate op, if it exists
-		 */
 		if (parent) {
 			/* update the clk tree topology */
 			flags = clk_enable_lock();
-- 
2.7.4
