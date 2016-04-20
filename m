From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:13:58 -0700
Subject: [PATCH] rtc: hym8563: Remove CLK_IS_ROOT
Message-ID: <1461114838-17604-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/rtc/rtc-hym8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index b1b4746a0eab..207270376b55 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -413,7 +413,7 @@ static struct clk *hym8563_clkout_register_clk(struct hym8563 *hym8563)
 
 	init.name = "hym8563-clkout";
 	init.ops = &hym8563_clkout_ops;
-	init.flags = CLK_IS_ROOT;
+	init.flags = 0;
 	init.parent_names = NULL;
 	init.num_parents = 0;
 	hym8563->clkout_hw.init = &init;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
