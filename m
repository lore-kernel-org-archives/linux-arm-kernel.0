From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:05:00 +0900
Subject: [PATCH 2/3] ARM: shmobile: bockw: fixup DMA mask
In-Reply-To: <cover.1387856124.git.horms+renesas@verge.net.au>
References: <cover.1387856124.git.horms+renesas@verge.net.au>
Message-ID: <4799e310caf0fb9078389766d0210d1c6133ad51.1387856124.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

4dcfa60071b3d23f0181f27d8519f12e37cefbb9
(ARM: DMA-API: better handing of DMA masks for coherent allocations)
exchanged DMA mask check method.
Below warning will appear without this patch

asoc-simple-card asoc-simple-card.0: \
  Coherent DMA mask 0xffffffffffffffff is larger than dma_addr_t allows
asoc-simple-card asoc-simple-card.0: \
  Driver did not use or check the return value from dma_set_coherent_mask()?

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 3861152..3c4995a 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -679,7 +679,7 @@ static void __init bockw_init(void)
 			.id             = i,
 			.data           = &rsnd_card_info[i],
 			.size_data      = sizeof(struct asoc_simple_card_info),
-			.dma_mask       = ~0,
+			.dma_mask	= DMA_BIT_MASK(32),
 		};
 
 		platform_device_register_full(&cardinfo);
-- 
1.8.4
