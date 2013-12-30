From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:25 +0100
Subject: [PATCH 11/17] ARM: iop: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388419771-30075-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/plat-iop/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index d70b733..6ad65d8 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -127,7 +127,7 @@ iop_timer_interrupt(int irq, void *dev_id)
 static struct irqaction iop_timer_irq = {
 	.name		= "IOP Timer Tick",
 	.handler	= iop_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.dev_id		= &iop_clockevent,
 };
 
-- 
1.7.9.5
