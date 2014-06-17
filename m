From: msalter@redhat.com (Mark Salter)
Date: Tue, 17 Jun 2014 13:07:03 -0400
Subject: [PATCH] arm64: remove define of ARCH_HAS_DMA_GET_REQUIRED_MASK
Message-ID: <1403024823-2180-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 defines ARCH_HAS_DMA_GET_REQUIRED_MASK but provides
no dma_get_required_mask() function. This leads to a link
error in drivers using dma_get_required_mask(). Remove the
define so the default dma_get_required_mask() is available.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/include/asm/dma-mapping.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 3a4572e..dc82e52 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -26,8 +26,6 @@
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
-#define ARCH_HAS_DMA_GET_REQUIRED_MASK
-
 #define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern struct dma_map_ops *dma_ops;
 extern struct dma_map_ops coherent_swiotlb_dma_ops;
-- 
1.9.0
