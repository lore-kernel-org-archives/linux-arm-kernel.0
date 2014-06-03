From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 3 Jun 2014 14:35:01 +0530
Subject: [PATCH 2/2] ARM: DRA7: hwmod: remove interrupts for DMA
In-Reply-To: <1401786301-5638-1-git-send-email-r.sricharan@ti.com>
References: <1401786301-5638-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1401786301-5638-3-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

DMA interrupts are now available in of, and the definitions are
duplicates in hwmod. This prevents us from dynamically allocating
interrupt resources for dma from devicetree.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 20b4398..31fd260 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -343,19 +343,10 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 };
 
 /* dma_system */
-static struct omap_hwmod_irq_info dra7xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + DRA7XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + DRA7XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + DRA7XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + DRA7XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod dra7xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &dra7xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
-	.mpu_irqs	= dra7xx_dma_system_irqs,
 	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5
