From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:26 -0500
Subject: [PATCH 08/23] ARM: mach-bcmring: use proper constant to identify DMA
 memory area
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-9-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Using VMALLOC_END implies a presumption about the layout which is best
avoided, even if in practice this would not change much.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-bcmring/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index b52b8de91b..8751582a6c 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -1614,7 +1614,7 @@ DMA_MemType_t dma_mem_type(void *addr)
 {
 	unsigned long addrVal = (unsigned long)addr;
 
-	if (addrVal >= VMALLOC_END) {
+	if (addrVal >= CONSISTENT_BASE) {
 		/* NOTE: DMA virtual memory space starts at 0xFFxxxxxx */
 
 		/* dma_alloc_xxx pages are physically and virtually contiguous */
-- 
1.7.7.1.431.g10b2a
