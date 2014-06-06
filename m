From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Fri, 6 Jun 2014 17:07:16 -0500
Subject: [PATCH] arm64/dma: Removing ARCH_HAS_DMA_GET_REQUIRED_MASK macro
Message-ID: <1402092436-2144-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Arm64 does not define dma_get_required_mask() function.
Therefore, it should not define the ARCH_HAS_DMA_GET_REQUIRED_MASK.
This causes build errors in some device drivers (e.g. mpt2sas)

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
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
