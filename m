From: eric@anholt.net (Eric Anholt)
Date: Thu,  4 Feb 2016 13:14:28 -0800
Subject: [PATCH] irqchip: bcm2836: Drop extra memory barrier in SMP boot.
Message-ID: <1454620468-31303-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The writel() immediately after this has a barrier, anyway.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2836.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 963065a..b6e950d 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -229,7 +229,6 @@ int __init bcm2836_smp_boot_secondary(unsigned int cpu,
 	unsigned long secondary_startup_phys =
 		(unsigned long)virt_to_phys((void *)secondary_startup);
 
-	dsb();
 	writel(secondary_startup_phys,
 	       intc.base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
 
-- 
2.7.0
