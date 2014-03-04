From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Tue,  4 Mar 2014 21:20:13 +0100
Subject: [PATCH] [RESEND] ARM: footbridge: remove obsolete IRQF_DISABLED
In-Reply-To: <1386395865-11910-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1386395865-11910-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1393964413-16829-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the IRQF_DISABLED flag from footbridge
code. It's a NOOP since 2.6.35.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/mach-footbridge/dc21285-timer.c |  2 +-
 arch/arm/mach-footbridge/dc21285.c       | 10 +++++-----
 arch/arm/mach-footbridge/isa-timer.c     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 3971104d32d4..952508f58ffb 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -105,7 +105,7 @@ static irqreturn_t timer1_interrupt(int irq, void *dev_id)
 static struct irqaction footbridge_timer_irq = {
 	.name		= "dc21285_timer1",
 	.handler	= timer1_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.dev_id		= &ckevt_dc21285,
 };
 
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 7c2fdae9a38b..96a3d73ef4bf 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -334,15 +334,15 @@ void __init dc21285_preinit(void)
 	/*
 	 * We don't care if these fail.
 	 */
-	dc21285_request_irq(IRQ_PCI_SERR, dc21285_serr_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_SERR, dc21285_serr_irq, 0,
 			    "PCI system error", &serr_timer);
-	dc21285_request_irq(IRQ_PCI_PERR, dc21285_parity_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_PERR, dc21285_parity_irq, 0,
 			    "PCI parity error", &perr_timer);
-	dc21285_request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, 0,
 			    "PCI abort", NULL);
-	dc21285_request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, 0,
 			    "Discard timer", NULL);
-	dc21285_request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, IRQF_DISABLED,
+	dc21285_request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, 0,
 			    "PCI data parity", NULL);
 
 	if (cfn_mode) {
diff --git a/arch/arm/mach-footbridge/isa-timer.c b/arch/arm/mach-footbridge/isa-timer.c
index d9301dd56354..b73f52e196b9 100644
--- a/arch/arm/mach-footbridge/isa-timer.c
+++ b/arch/arm/mach-footbridge/isa-timer.c
@@ -27,7 +27,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 static struct irqaction pit_timer_irq = {
 	.name		= "pit",
 	.handler	= pit_timer_interrupt,
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.dev_id		= &i8253_clockevent,
 };
 
-- 
1.8.3.2
