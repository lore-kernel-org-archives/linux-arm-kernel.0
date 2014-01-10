From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 10 Jan 2014 11:32:22 +0900
Subject: [PATCH 1/3] irqchip: exynos-combiner: call handle_bad_irq directly
Message-ID: <1389321142-4073-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is inspired from following commit
 aec0095653: (irqchip: gic: Call handle_bad_irq() directly)

Also this will help in removing unwanted inclusion
of header file "asm/mach/irq.h"

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/irqchip/exynos-combiner.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 40e6440..f8636a6 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -17,7 +17,6 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <asm/mach/irq.h>
 
 #include "irqchip.h"
 
@@ -81,7 +80,7 @@ static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	cascade_irq = irq_find_mapping(combiner_irq_domain, combiner_irq);
 
 	if (unlikely(!cascade_irq))
-		do_bad_IRQ(irq, desc);
+		handle_bad_irq(irq, desc);
 	else
 		generic_handle_irq(cascade_irq);
 
-- 
1.7.10.4
