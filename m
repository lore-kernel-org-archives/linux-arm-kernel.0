From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sun, 13 Oct 2013 06:39:54 +0200
Subject: [PATCH] clocksource: vt8500: remove deprecated IRQF_DISABLED
Message-ID: <1381639194-6861-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 drivers/clocksource/vt8500_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 64f553f..414063f 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -124,7 +124,7 @@ static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction irq = {
 	.name    = "vt8500_timer",
-	.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags   = IRQF_TIMER | IRQF_IRQPOLL,
 	.handler = vt8500_timer_interrupt,
 	.dev_id  = &clockevent,
 };
-- 
1.8.1.2
