From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:05 -0500
Subject: [PATCH 17/35] arm: omap: irq: use compatible flag to figure out
 number of IRQ lines
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-18-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so far, only am33xx has 128 lines, all other devices
have only 96.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 97845df..7a4ead3 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -310,6 +310,9 @@ static int __init intc_of_init(struct device_node *node,
 		return -EINVAL;
 	}
 
+	if (of_device_is_compatible(node, "ti,am33xx-intc"))
+		nr_irq = 128;
+
 	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
 		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
 
-- 
2.0.1.563.g66f467c
