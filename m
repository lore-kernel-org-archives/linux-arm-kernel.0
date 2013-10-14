From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Oct 2013 21:07:48 +0200
Subject: [PATCH 3/3] clocksource: sun4i: remove IRQF_DISABLED
In-Reply-To: <1381777668-32565-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1381777668-32565-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1381777668-32565-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQF_DISABLED is a no-op nowadays, so we can safely remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clocksource/sun4i_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 46008f9..2fb4695 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -133,7 +133,7 @@ static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction sun4i_timer_irq = {
 	.name = "sun4i_timer0",
-	.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags = IRQF_TIMER | IRQF_IRQPOLL,
 	.handler = sun4i_timer_interrupt,
 	.dev_id = &sun4i_clockevent,
 };
-- 
1.8.4
