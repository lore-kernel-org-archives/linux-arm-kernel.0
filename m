From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:28 +0100
Subject: [PATCH 14/17] ARM: netx: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388419771-30075-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-netx/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index 6df42e6..3177c7a 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -99,7 +99,7 @@ netx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction netx_timer_irq = {
 	.name		= "NetX Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= netx_timer_interrupt,
 };
 
-- 
1.7.9.5
