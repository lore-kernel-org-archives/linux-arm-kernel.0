From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Dec 2013 09:58:06 +0900
Subject: [PATCH 1/3] ARM: shmobile: armadillo: Fix coherent DMA mask
In-Reply-To: <cover.1388364591.git.horms+renesas@verge.net.au>
References: <cover.1388364591.git.horms+renesas@verge.net.au>
Message-ID: <dcd740b645003b866d7eb30d13d34d0729cce9db.1388364591.git.horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-armadillo800eva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c186891..8ea87bd 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -483,7 +483,7 @@ static struct platform_device lcdc0_device = {
 	.id		= 0,
 	.dev	= {
 		.platform_data	= &lcdc0_info,
-		.coherent_dma_mask = ~0,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -580,7 +580,7 @@ static struct platform_device hdmi_lcdc_device = {
 	.id		= 1,
 	.dev	= {
 		.platform_data	= &hdmi_lcdc_info,
-		.coherent_dma_mask = ~0,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
-- 
1.8.4
