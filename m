From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon,  9 Dec 2013 06:02:46 +0100
Subject: [PATCH][RESEND] ARM: mmp: remove deprecated IRQF_DISABLED
In-Reply-To: <1381548299-5093-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381548299-5093-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1386565366-19286-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-mmp/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 7ac41e83cfef..6aacc9b050f5 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -186,7 +186,7 @@ static void __init timer_config(void)
 
 static struct irqaction timer_irq = {
 	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= timer_interrupt,
 	.dev_id		= &ckevt,
 };
-- 
1.8.3.2
