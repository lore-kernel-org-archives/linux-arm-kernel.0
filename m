From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:17 +0100
Subject: [PATCH 03/17] ARM: sa1100: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388419771-30075-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-sa1100/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 6fd4acb..4852c08 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -112,7 +112,7 @@ static struct clock_event_device ckevt_sa1100_osmr0 = {
 
 static struct irqaction sa1100_timer_irq = {
 	.name		= "ost0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= sa1100_ost0_interrupt,
 	.dev_id		= &ckevt_sa1100_osmr0,
 };
-- 
1.7.9.5
