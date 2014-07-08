From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:30 +0100
Subject: [PATCH 07/15] irqchip: mxs: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-mxs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 4044ff2..e4acf1e 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -78,8 +78,7 @@ asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 
 	irqnr = __raw_readl(icoll_base + HW_ICOLL_STAT_OFFSET);
 	__raw_writel(irqnr, icoll_base + HW_ICOLL_VECTOR);
-	irqnr = irq_find_mapping(icoll_domain, irqnr);
-	handle_IRQ(irqnr, regs);
+	handle_domain_irq(icoll_domain, irqnr, regs);
 }
 
 static int icoll_irq_domain_map(struct irq_domain *d, unsigned int virq,
-- 
2.0.0
