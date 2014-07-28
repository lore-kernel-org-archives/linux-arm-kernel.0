From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:07 -0500
Subject: [PATCH 19/35] arm: omap: irq: drop ti,intc-size support
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-20-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we don't need that anymore since specific
devices are passing correct compatible flags.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 7a4ead3..e70c26e 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -313,9 +313,6 @@ static int __init intc_of_init(struct device_node *node,
 	if (of_device_is_compatible(node, "ti,am33xx-intc"))
 		nr_irq = 128;
 
-	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
-		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
-
 	omap_init_irq(res.start, nr_irq, of_node_get(node));
 
 	set_handle_irq(omap2_intc_handle_irq);
-- 
2.0.1.563.g66f467c
