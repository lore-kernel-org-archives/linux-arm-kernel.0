From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:32 +0100
Subject: [PATCH v2 17/26] irqchip: zevio: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-zevio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index ceb3a43..e4ef74e 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -56,8 +56,7 @@ static void __exception_irq_entry zevio_handle_irq(struct pt_regs *regs)
 
 	while (readl(zevio_irq_io + IO_STATUS)) {
 		irqnr = readl(zevio_irq_io + IO_CURRENT);
-		irqnr = irq_find_mapping(zevio_irq_domain, irqnr);
-		handle_IRQ(irqnr, regs);
+		handle_domain_irq(zevio_irq_domain, irqnr, regs);
 	};
 }
 
-- 
2.0.4
