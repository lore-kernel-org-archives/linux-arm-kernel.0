From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:16:01 -0500
Subject: [PATCH 13/35] arm: omap: irq: call set_handle_irq() from intc_of_init
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <1406582183-696-14-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will let us drop .handle_irq and .init_irq fields
from our generic machine_descs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e6997c5..e452411 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -314,6 +314,8 @@ static int __init intc_of_init(struct device_node *node,
 
 	omap_init_irq(res.start, nr_irq, of_node_get(node));
 
+	set_handle_irq(omap2_intc_handle_irq);
+
 	return 0;
 }
 
-- 
2.0.1.563.g66f467c
