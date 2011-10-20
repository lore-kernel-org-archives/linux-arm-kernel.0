From: jhbird.choi@gmail.com (jhbird.choi at gmail.com)
Date: Thu, 20 Oct 2011 22:45:53 +0900
Subject: [RESEND][PATCH] PM / Clocks: Remove redundant NULL checks before kfree
Message-ID: <1319118353-2387-1-git-send-email-jhbird.choi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@gmail.com>

Signed-off-by: Jonghwan Choi <jhbird.choi@gmail.com>
---
 drivers/base/power/clock_ops.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index b97294e..3ecc303 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -114,9 +114,7 @@ static void __pm_clk_remove(struct pm_clock_entry *ce)
 			clk_put(ce->clk);
 	}
 
-	if (ce->con_id)
-		kfree(ce->con_id);
-
+	kfree(ce->con_id);
 	kfree(ce);
 }
 
-- 
1.7.0.4
