From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:23 +0100
Subject: [PATCH 09/17] ARM: u300: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388419771-30075-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-u300/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 9724e4e..50d73ae 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -329,7 +329,7 @@ static irqreturn_t u300_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction u300_timer_irq = {
 	.name		= "U300 Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= u300_timer_interrupt,
 };
 
-- 
1.7.9.5
