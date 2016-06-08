From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:59:58 +0100
Subject: [PATCH] irqchip/bcm7120-l2: make probe functions static
Message-ID: <1465408798-16201-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The probe functions in this driver are not exported or declared
for use elsewhere, so make them static to fix the warnings:

drivers/irqchip/irq-bcm7120-l2.c:218:12: warning: symbol 'bcm7120_l2_intc_probe' was not declared. Should it be static?
drivers/irqchip/irq-bcm7120-l2.c:342:12: warning: symbol 'bcm7120_l2_intc_probe_7120' was not declared. Should it be static?
drivers/irqchip/irq-bcm7120-l2.c:349:12: warning: symbol 'bcm7120_l2_intc_probe_3380' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mips at linux-mips.org
---
 drivers/irqchip/irq-bcm7120-l2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 61b18ab..0ec9263 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -215,7 +215,7 @@ static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
 	return 0;
 }
 
-int __init bcm7120_l2_intc_probe(struct device_node *dn,
+static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 				 struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
 					struct bcm7120_l2_intc_data *),
@@ -339,15 +339,15 @@ out_unmap:
 	return ret;
 }
 
-int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
-				      struct device_node *parent)
+static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
+					     struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
-				      struct device_node *parent)
+static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
+					     struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
-- 
2.8.1
