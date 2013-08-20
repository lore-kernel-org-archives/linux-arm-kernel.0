From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 12:45:52 -0300
Subject: [PATCH v3 3/5] clocksource: armada-370-xp: Replace WARN_ON with BUG_ON
In-Reply-To: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377013554-23389-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the clock fails to be obtained and the timer fails to be properly
registered, the kernel will freeze real soon. Instead, let's BUG()
where the actual problem is located.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 11d91e5..fca318f 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -304,7 +304,7 @@ static void __init armada_370_timer_init(struct device_node *np)
 {
 	struct clk *clk = of_clk_get(np, 0);
 
-	WARN_ON(IS_ERR(clk));
+	BUG_ON(IS_ERR(clk));
 	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
 	timer25Mhz = false;
 
-- 
1.8.1.5
