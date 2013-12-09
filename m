From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  9 Dec 2013 05:55:56 +0100
Subject: [PATCH][RESEND] ARM: LPC32xx: remove deprecated IRQF_DISABLED
In-Reply-To: <1381548100-5035-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381548100-5035-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1386564956-19152-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-lpc32xx/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 20eab63d10ba..4e5837299c04 100644
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
1.8.3.2
