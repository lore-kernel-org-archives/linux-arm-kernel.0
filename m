From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 19 Nov 2013 10:22:11 +1100
Subject: [PATCH] ARM: ep93xx: remove deprecated IRQF_DISABLED
Message-ID: <1384816931-3680-1-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Opdenacker <michael.opdenacker@free-electrons.com>

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 3f12b88..fcc965f 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -136,7 +136,7 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction ep93xx_timer_irq = {
 	.name		= "ep93xx timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= ep93xx_timer_interrupt,
 };
 
-- 
1.7.9.7
