From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 17 Oct 2013 18:43:17 +0100
Subject: [PATCH v8 02/19] arm64: define DMA_ERROR_CODE
In-Reply-To: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
Message-ID: <1382031814-8782-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: will.deacon at arm.com

Changes in v8:
- cast to dma_addr_t before returning.
---
 arch/arm64/include/asm/dma-mapping.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 8d18100..59206b1 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -25,6 +25,7 @@
 
 #define ARCH_HAS_DMA_GET_REQUIRED_MASK
 
+#define DMA_ERROR_CODE	(~(dma_addr_t)0)
 extern struct dma_map_ops *dma_ops;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
-- 
1.7.2.5
