From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:08:48 -0600
Subject: [RFT/RFC/PATCH 01/31] arm: omap: irq: make omap_irq_base global
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is in preparation for removing the pointless
irq_banks array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e022a86..748f86b 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -68,6 +68,7 @@ static struct omap_irq_bank {
 };
 
 static struct irq_domain *domain;
+static void __iomem *omap_irq_base;
 
 /* Structure to save interrupt controller context */
 struct omap3_intc_regs {
@@ -161,7 +162,6 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 static void __init omap_init_irq(u32 base, int nr_irqs,
 				 struct device_node *node)
 {
-	void __iomem *omap_irq_base;
 	unsigned long nr_of_irqs = 0;
 	unsigned int nr_banks = 0;
 	int i, j, irq_base;
-- 
1.8.4.GIT
