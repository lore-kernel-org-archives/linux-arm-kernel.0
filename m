From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:29 +0100
Subject: [PATCH v2 14/26] irqchip: versatile-fpga: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-15-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-versatile-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index ccf5854..1ab4517 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -96,7 +96,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
 
 	while ((status  = readl(f->base + IRQ_STATUS))) {
 		irq = ffs(status) - 1;
-		handle_IRQ(irq_find_mapping(f->domain, irq), regs);
+		handle_domain_irq(f->domain, irq, regs);
 		handled = 1;
 	}
 
-- 
2.0.4
