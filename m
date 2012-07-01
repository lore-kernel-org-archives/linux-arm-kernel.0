From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun,  1 Jul 2012 23:18:59 +0200
Subject: [PATCH] clk: __clk_set_parent: set uninitialized variable
Message-ID: <1341177539-27716-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following warning:

    drivers/clk/clk.c: In function '__clk_set_parent':
    drivers/clk/clk.c:1083:5: warning: 'i' may be used uninitialized in this function [-Wuninitialized]

which has been introduced with commit:

    commit 7975059db572eb47f0fb272a62afeae272a4b209
    Author: Rajendra Nayak <rnayak@ti.com>
    Date:   Wed Jun 6 14:41:31 2012 +0530

        clk: Allow late cache allocation for clk->parents

This patch applies to linux-3.5-rc5

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

please check if this is the correct fix. The original patch has been
schedules for stable, this fix may be a candicate, too.

regards, Marc


 drivers/clk/clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dcbe056..60d1bb4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1063,7 +1063,7 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
 	struct clk *old_parent;
 	unsigned long flags;
 	int ret = -EINVAL;
-	u8 i;
+	u8 i = 0;
 
 	old_parent = clk->parent;
 
-- 
1.7.10
