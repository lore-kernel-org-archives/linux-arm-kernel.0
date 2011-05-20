From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:16 +0200
Subject: [PATCH 1/9] ARM i.MX tzic: do not depend on MXC_INTERNAL_IRQS
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This becomes meaningless in subsequent patches.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/tzic.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 57f9395..710f2e7 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -49,6 +49,8 @@
 
 void __iomem *tzic_base; /* Used as irq controller base in entry-macro.S */
 
+#define TZIC_NUM_IRQS 128
+
 #ifdef CONFIG_FIQ
 static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 {
@@ -166,7 +168,7 @@ void __init tzic_init_irq(void __iomem *irqbase)
 
 	/* all IRQ no FIQ Warning :: No selection */
 
-	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
+	for (i = 0; i < TZIC_NUM_IRQS; i++) {
 		irq_set_chip_and_handler(i, &mxc_tzic_chip.base,
 					 handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
-- 
1.7.4.1
