From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 03:07:21 -0400
Subject: [PATCH 10/19] ARM: mach-bcmring: use proper constant to identify DMA
	memory area
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <1316156850-31013-11-git-send-email-nico@fluxnic.net>
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
index 0ca0005066..42021804b9 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -1613,7 +1613,7 @@ DMA_MemType_t dma_mem_type(void *addr)
 {
 	unsigned long addrVal = (unsigned long)addr;
 
-	if (addrVal >= VMALLOC_END) {
+	if (addrVal >= CONSISTENT_BASE) {
 		/* NOTE: DMA virtual memory space starts at 0xFFxxxxxx */
 
 		/* dma_alloc_xxx pages are physically and virtually contiguous */
-- 
1.7.7-rc0
