From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:09:12 -0600
Subject: [RFT/RFC/PATCH 25/31] arm: omap: irq: drop omap3_intc_handle_irq()
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-26-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

there are no more users for that function, we
can safely drop it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h | 1 -
 arch/arm/mach-omap2/irq.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 4df64c36..bfc5e5f 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -200,7 +200,6 @@ void omap3_init_irq(void);
 void ti81xx_init_irq(void);
 extern int omap_irq_pending(void);
 void omap2_intc_handle_irq(struct pt_regs *regs);
-void omap3_intc_handle_irq(struct pt_regs *regs);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index d936955..f72af7a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -329,8 +329,3 @@ static int __init intc_of_init(struct device_node *node,
 IRQCHIP_DECLARE(omap2_intc, "ti,omap2-intc", intc_of_init);
 IRQCHIP_DECLARE(omap3_intc, "ti,omap3-intc", intc_of_init);
 IRQCHIP_DECLARE(am33xx_intc, "ti,am33xx-intc", intc_of_init);
-
-asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
-{
-	omap_intc_handle_irq(regs);
-}
-- 
1.8.4.GIT
