From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:08:57 -0600
Subject: [RFT/RFC/PATCH 10/31] arm: omap: irq: always define omap3 support
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-11-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove ifdef around omap3 INTC support. This
will make it easier to reuse code for PM.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 52386e7..b586317 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -257,7 +257,6 @@ void __init omap_intc_of_init(void)
 	of_irq_init(irq_match);
 }
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
 static struct omap_intc_regs intc_context;
 
 void omap_intc_save_context(void)
@@ -325,4 +324,3 @@ asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs
 {
 	omap_intc_handle_irq(regs);
 }
-#endif /* CONFIG_ARCH_OMAP3 */
-- 
1.8.4.GIT
