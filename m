From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 04 Jul 2011 16:12:21 +0800
Subject: [PATCH] ARM: DMA: Silence declared inside parameter list warning
	for !CONFIG_MMU
Message-ID: <1309767141.3964.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below warning, the struct dma_coherent_area takes no space if !CONFIG_MMU.

  CC      arch/arm/mm/dma-mapping.o
arch/arm/mm/dma-mapping.c:309: warning: 'struct dma_coherent_area' declared inside parameter list
arch/arm/mm/dma-mapping.c:309: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mm/dma-mapping.c:334: warning: 'struct dma_coherent_area' declared inside parameter list
arch/arm/mm/dma-mapping.c:374: warning: 'struct dma_coherent_area' declared inside parameter list

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8089499..da3b33a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -297,6 +297,8 @@ static void dma_free_area(void *cpu_addr, size_t size, struct dma_coherent_area
 #define coherent_wc_area NULL
 #define coherent_dma_area NULL
 
+struct dma_coherent_area { };
+
 void dma_coherent_reserve(void)
 {
 }
-- 
1.7.4.1
