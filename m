From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 29 Oct 2017 22:20:26 +0100
Subject: [PATCH 09/17] clocksource/drivers/owl: pr_err() strings should end
 with newlines
In-Reply-To: <1509312035-17368-1-git-send-email-daniel.lezcano@linaro.org>
References: <c4d8b83b-b884-415b-8c92-b195de1dae7f@linaro.org>
 <1509312035-17368-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1509312035-17368-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

pr_err() messages should end with a new-line to avoid other messages being
concatenated.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
2.7.4
