From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:36 -0300
Subject: [PATCH 9/17] ARM: mach-imx: irq-common: Remove imx_irq_set_priority()
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-9-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_irq_set_priority() is not used anywhere, so remove it.

This fixes the following sparse warnings:

arch/arm/mach-imx/irq-common.c:24:5: warning: symbol 'imx_irq_set_priority' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/irq-common.c |   19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/mach-imx/irq-common.c b/arch/arm/mach-imx/irq-common.c
index b6e1145..4b34f52 100644
--- a/arch/arm/mach-imx/irq-common.c
+++ b/arch/arm/mach-imx/irq-common.c
@@ -21,25 +21,6 @@
 
 #include "irq-common.h"
 
-int imx_irq_set_priority(unsigned char irq, unsigned char prio)
-{
-	struct irq_chip_generic *gc;
-	struct mxc_extra_irq *exirq;
-	int ret;
-
-	ret = -ENOSYS;
-
-	gc = irq_get_chip_data(irq);
-	if (gc && gc->private) {
-		exirq = gc->private;
-		if (exirq->set_priority)
-			ret = exirq->set_priority(irq, prio);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(imx_irq_set_priority);
-
 int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
 {
 	struct irq_chip_generic *gc;
-- 
1.7.9.5
