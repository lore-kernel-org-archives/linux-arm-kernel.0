From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:38 +0100
Subject: [PATCH 15/15] irqchip: zevio: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-zevio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index ceb3a43..1b7c67d 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -56,8 +56,7 @@ static void __exception_irq_entry zevio_handle_irq(struct pt_regs *regs)
 
 	while (readl(zevio_irq_io + IO_STATUS)) {
 		irqnr = readl(zevio_irq_io + IO_CURRENT);
-		irqnr = irq_find_mapping(zevio_irq_domain, irqnr);
-		handle_IRQ(irqnr, regs);
+		handle_domain_IRQ(zevio_irq_domain, irqnr, regs);
 	};
 }
 
-- 
2.0.0
