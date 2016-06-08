From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:53:34 +0100
Subject: [PATCH] irqchip/gic-v2m: fix missing include of
 <linux/irqchip/arm-gic.h>
Message-ID: <1465408414-13698-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the missing declaration of gicv2m_init() by including the
file <linux/irqchip/arm-gic.h> which defines it. Fixes the
warning:

drivers/irqchip/irq-gic-v2m.c:517:12: warning: symbol 'gicv2m_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-gic-v2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index ad0d296..35eb7ac 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/irqchip/arm-gic.h>
 
 /*
 * MSI_TYPER:
-- 
2.8.1
