From: opendmb@gmail.com (Doug Berger)
Date: Wed, 19 Jul 2017 12:07:30 -0700
Subject: [PATCH v2 2/6] irqchip/tango: Use irq_gc_mask_disable_and_ack_set
In-Reply-To: <20170719190734.18566-1-opendmb@gmail.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
Message-ID: <20170719190734.18566-3-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>

The only usage of the irq_gc_mask_disable_reg_and_ack() function
is by the Tango irqchip driver. This usage is replaced by the
irq_gc_mask_disable_and_ack_set() function since it provides the
intended functionality.

Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-tango.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index bdbb5c0ff7fe..0c085303a583 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -141,7 +141,7 @@ static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
 	for (i = 0; i < 2; i++) {
 		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
 		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
-		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_reg_and_ack;
+		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
 		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
 		ct[i].chip.irq_set_type = tangox_irq_set_type;
 		ct[i].chip.name = gc->domain->name;
-- 
2.13.0
