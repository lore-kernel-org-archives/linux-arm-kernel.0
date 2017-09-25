From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 25 Sep 2017 13:46:40 +0530
Subject: [PATCH 2/3] clocksource: owl: pr_err() strings should end with
 newlines
In-Reply-To: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1506327401-30521-3-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pr_err() messages should terminated with a new-line to avoid
other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/owl-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index d19c53c..c686305 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -125,7 +125,7 @@ static int __init owl_timer_init(struct device_node *node)
 
 	owl_timer_base = of_io_request_and_map(node, 0, "owl-timer");
 	if (IS_ERR(owl_timer_base)) {
-		pr_err("Can't map timer registers");
+		pr_err("Can't map timer registers\n");
 		return PTR_ERR(owl_timer_base);
 	}
 
@@ -134,7 +134,7 @@ static int __init owl_timer_init(struct device_node *node)
 
 	timer1_irq = of_irq_get_byname(node, "timer1");
 	if (timer1_irq <= 0) {
-		pr_err("Can't parse timer1 IRQ");
+		pr_err("Can't parse timer1 IRQ\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
