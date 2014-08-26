From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:30 +0100
Subject: [PATCH v2 15/26] irqchip: vic: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-vic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 7d35287..54089de 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -219,7 +219,7 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
 
 	while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
 		irq = ffs(stat) - 1;
-		handle_IRQ(irq_find_mapping(vic->domain, irq), regs);
+		handle_domain_irq(vic->domain, irq, regs);
 		handled = 1;
 	}
 
-- 
2.0.4
