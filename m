From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 17:09:15 +0100
Subject: [PATCH 01/17] ARM: spear: Remove deprecated IRQF_DISABLED flag
Message-ID: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a NOOP and scheduled to be removed

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-spear/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d449673..218ba5b 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -172,7 +172,7 @@ static irqreturn_t spear_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction spear_timer_irq = {
 	.name = "timer",
-	.flags = IRQF_DISABLED | IRQF_TIMER,
+	.flags = IRQF_TIMER,
 	.handler = spear_timer_interrupt
 };
 
-- 
1.7.9.5
