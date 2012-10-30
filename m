From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Oct 2012 09:54:20 -0500
Subject: [PATCH 3/3] ARM: highbank: use common irqchip_init
In-Reply-To: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
Message-ID: <1351608860-24617-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Now that we have common irqchip init, use it on highbank platform.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 40e36a5..27b77da 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -82,11 +83,6 @@ void highbank_set_cpu_jump(int cpu, void *jump_addr)
 			  HB_JUMP_TABLE_PHYS(cpu) + 15);
 }
 
-const static struct of_device_id irq_match[] = {
-	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{}
-};
-
 #ifdef CONFIG_CACHE_L2X0
 static void highbank_l2x0_disable(void)
 {
@@ -97,7 +93,7 @@ static void highbank_l2x0_disable(void)
 
 static void __init highbank_init_irq(void)
 {
-	of_irq_init(irq_match);
+	irqchip_init();
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Enable PL310 L2 Cache controller */
-- 
1.7.10.4
