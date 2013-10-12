From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sat, 12 Oct 2013 05:49:20 +0200
Subject: [PATCH] arm: plat-orion: remove deprecated IRQF_DISABLED
Message-ID: <1381549760-5432-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/plat-orion/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 9d2b2ac..df671d0 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -174,7 +174,7 @@ static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction orion_timer_irq = {
 	.name		= "orion_tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.flags		= IRQF_TIMER,
 	.handler	= orion_timer_interrupt
 };
 
-- 
1.8.1.2
