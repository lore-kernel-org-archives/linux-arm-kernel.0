From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:21 +0900
Subject: [PATCH 09/16] ARM: shmobile: Armadillo 800 EVA: set proper DMA masks
 for Ether device
In-Reply-To: <cover.1392960310.git.horms+renesas@verge.net.au>
References: <cover.1392960310.git.horms+renesas@verge.net.au>
Message-ID: <78060840cd2286c0e382641e60dcd4145f82f881.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
ability.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 93533e2..4da3da7 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -383,6 +383,8 @@ static struct platform_device sh_eth_device = {
 	.id = -1,
 	.dev = {
 		.platform_data = &sh_eth_platdata,
+		.dma_mask = &sh_eth_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource = sh_eth_resources,
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
-- 
1.8.5.2
