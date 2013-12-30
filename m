From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Dec 2013 09:58:08 +0900
Subject: [PATCH 3/3] ARM: shmobile: mackerel: Fix coherent DMA mask
In-Reply-To: <cover.1388364591.git.horms+renesas@verge.net.au>
References: <cover.1388364591.git.horms+renesas@verge.net.au>
Message-ID: <b6328a6b7ba57fc84c38248f6f0e387e1170f1a8.1388364591.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Commit 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 ("ARM: DMA-API: better
handing of DMA masks for coherent allocations") added an additional
check to the coherent DMA mask that results in an error when the mask is
larger than what dma_addr_t can address.

Set the LCDC coherent DMA mask to DMA_BIT_MASK(32) instead of ~0 to fix
the problem.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index af06753..e721d2c 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -409,7 +409,7 @@ static struct platform_device lcdc_device = {
 	.resource	= lcdc_resources,
 	.dev	= {
 		.platform_data	= &lcdc_info,
-		.coherent_dma_mask = ~0,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -499,7 +499,7 @@ static struct platform_device hdmi_lcdc_device = {
 	.id		= 1,
 	.dev	= {
 		.platform_data	= &hdmi_lcdc_info,
-		.coherent_dma_mask = ~0,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
-- 
1.8.4
