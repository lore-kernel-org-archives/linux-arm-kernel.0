From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  9 Dec 2013 05:46:56 +0100
Subject: [PATCH][RESEND] ARM: cns3xxx: remove deprecated IRQF_DISABLED
In-Reply-To: <1381546874-4777-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381546874-4777-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1386564416-18947-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-cns3xxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index e38b279f402c..384dc859e6c6 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -155,7 +155,7 @@ static irqreturn_t cns3xxx_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction cns3xxx_timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= cns3xxx_timer_interrupt,
 };
 
-- 
1.8.3.2
