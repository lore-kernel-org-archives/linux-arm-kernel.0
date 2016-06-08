From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:44:32 +0100
Subject: [PATCH] irqchip/omap-intc: fix missing
 <linux/irqchip/irq-omap-intc.h> include
Message-ID: <1465407872-10299-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the missing include of <linux/irqchip/irq-omap-intc.h> which
declares all the missing functions from the following warnings:

drivers/irqchip/irq-omap-intc.c:84:6: warning: symbol 'omap_intc_save_context' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:105:6: warning: symbol 'omap_intc_restore_context' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:124:6: warning: symbol 'omap3_intc_prepare_idle' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:134:6: warning: symbol 'omap3_intc_resume_idle' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:173:5: warning: symbol 'omap_irq_pending' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:183:6: warning: symbol 'omap3_intc_suspend' was not declared. Should it be static?
drivers/irqchip/irq-omap-intc.c:365:13: warning: symbol 'omap3_init_irq' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-omap at vger.kernel.org
---
 drivers/irqchip/irq-omap-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 9d1bcfc..b04a8ac 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -23,6 +23,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <linux/irqchip/irq-omap-intc.h>
+
 /* Define these here for now until we drop all board-files */
 #define OMAP24XX_IC_BASE	0x480fe000
 #define OMAP34XX_IC_BASE	0x48200000
-- 
2.8.1
