From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:09:06 -0600
Subject: [RFT/RFC/PATCH 19/31] arm: omap: irq: use compatible flag to figure
 out number of IRQ lines
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-20-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so far, only am33xx has 128 lines, all other devices
have only 96.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1e1015c..fd89488 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -313,6 +313,9 @@ static int __init intc_of_init(struct device_node *node,
 		return -EINVAL;
 	}
 
+	if (of_device_is_compatible(node, "ti,am33xx-intc"))
+		nr_irq = 128;
+
 	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
 		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
 
-- 
1.8.4.GIT
