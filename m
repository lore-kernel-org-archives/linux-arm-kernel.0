From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 13 Mar 2013 15:17:49 +0530
Subject: [PATCH 1/1] clk: Fix incorrect return type in clk.c
Message-ID: <1363168069-11331-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return type of function clk_propagate_rate_change is a pointer.
But 0 was being returned. Change it to NULL.
Silences the following warning:
drivers/clk/clk.c:977:24: warning: Using plain integer as NULL pointer

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/clk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ed87b24..467b31f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -974,7 +974,7 @@ static struct clk *clk_propagate_rate_change(struct clk *clk, unsigned long even
 	int ret = NOTIFY_DONE;
 
 	if (clk->rate == clk->new_rate)
-		return 0;
+		return NULL;
 
 	if (clk->notifier_count) {
 		ret = __clk_notify(clk, event, clk->rate, clk->new_rate);
-- 
1.7.4.1
