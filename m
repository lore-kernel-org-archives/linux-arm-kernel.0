From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Nov 2013 12:09:02 -0600
Subject: [RFT/RFC/PATCH 15/31] arm: omap: irq: call set_handle_irq() from
 intc_of_init
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <1384970958-4118-16-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will let us drop .handle_irq and .init_irq fields
from our generic machine_descs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8ef2bfd..503d345 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -317,6 +317,8 @@ static int __init intc_of_init(struct device_node *node,
 
 	omap_init_irq(res.start, nr_irq, of_node_get(node));
 
+	set_handle_irq(omap2_intc_handle_irq);
+
 	return 0;
 }
 
-- 
1.8.4.GIT
