From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:41:37 +0100
Subject: [PATCH] irqchip/bcm2836: make bcm2836_smp_boot_secondary static
Message-ID: <1465407697-8116-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bcm2836_smp_boot_secondary() is not declared or used elsewhere
so make it static to fix the following warning:

drivers/irqchip/irq-bcm2836.c:227:12: warning: symbol 'bcm2836_smp_boot_secondary' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-bcm2836.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 72ff1d5..6c72e60 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -224,8 +224,8 @@ static struct notifier_block bcm2836_arm_irqchip_cpu_notifier = {
 };
 
 #ifdef CONFIG_ARM
-int __init bcm2836_smp_boot_secondary(unsigned int cpu,
-				      struct task_struct *idle)
+static int __init bcm2836_smp_boot_secondary(unsigned int cpu,
+					     struct task_struct *idle)
 {
 	unsigned long secondary_startup_phys =
 		(unsigned long)virt_to_phys((void *)secondary_startup);
-- 
2.8.1
