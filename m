From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:27 +0100
Subject: [PATCH 13/17] ARM: lpc32xx: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388419771-30075-13-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-lpc32xx/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 20eab63..4e58372 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -90,7 +90,7 @@ static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction lpc32xx_timer_irq = {
 	.name		= "LPC32XX Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= lpc32xx_timer_interrupt,
 };
 
-- 
1.7.9.5
