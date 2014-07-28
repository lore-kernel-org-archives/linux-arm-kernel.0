From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:04 -0500
Subject: [PATCH 16/35] arm: omap: irq: add specific compatibles for omap3 and
 am33xx devices
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-17-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

with this, we can use a compatible flag to figure
out how many irq lines are wired up, no need for
our TI-specific ti,intc-size binding.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 465d725..97845df 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -320,7 +320,9 @@ static int __init intc_of_init(struct device_node *node,
 	return 0;
 }
 
-IRQCHIP_DECLARE(omap_intc, "ti,omap2-intc", intc_of_init);
+IRQCHIP_DECLARE(omap2_intc, "ti,omap2-intc", intc_of_init);
+IRQCHIP_DECLARE(omap3_intc, "ti,omap3-intc", intc_of_init);
+IRQCHIP_DECLARE(am33xx_intc, "ti,am33xx-intc", intc_of_init);
 
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
 {
-- 
2.0.1.563.g66f467c
