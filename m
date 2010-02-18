From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 18 Feb 2010 14:29:08 +0530
Subject: [PATCH 3/9] omap4: sdma: Enable the idle modes on omap4
In-Reply-To: <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables smart-idle idlemodes and autoidle for sDMA
on OMAP4

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 30ff525..5ec96db 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2138,7 +2138,7 @@ static int __init omap_init_dma(void)
 		setup_irq(irq, &omap24xx_dma_irq);
 	}
 
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		/* Enable smartidle idlemodes and autoidle */
 		u32 v = dma_read(OCP_SYSCONFIG);
 		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
-- 
1.6.0.4
