From: khilman@ti.com (Kevin Hilman)
Date: Tue,  8 May 2012 15:02:54 -0700
Subject: [PATCH 1/3] ARM: OMAP2+: INTC: fix Kconfig option for TI81XX
In-Reply-To: <1336514576-4870-1-git-send-email-khilman@ti.com>
References: <1336514576-4870-1-git-send-email-khilman@ti.com>
Message-ID: <1336514576-4870-2-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The INTC core is using a Kconfig option for TI816x which doesn't
exist.  Convert it to use TI81XX.

Cc: Hemant Pedanekar <hemantp@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 65f0d257..a5da010 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -231,7 +231,7 @@ static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs
 			goto out;
 
 		irqnr = readl_relaxed(base_addr + 0xd8);
-#ifdef CONFIG_SOC_OMAPTI816X
+#ifdef CONFIG_SOC_OMAPTI81XX
 		if (irqnr)
 			goto out;
 		irqnr = readl_relaxed(base_addr + 0xf8);
-- 
1.7.9.2
