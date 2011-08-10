From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Aug 2011 16:03:25 +0100
Subject: [PATCH v7 02/16] ARM: LPAE: Cast the dma_addr_t argument to unsigned
	long in dma_to_virt
In-Reply-To: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1312988619-16804-3-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to avoid a compiler warning when invoking the __bus_to_virt()
macro. The dma_to_virt() function gets addresses within the 32-bit
range.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/dma-mapping.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 7a21d0b..28b7ee8 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -32,7 +32,7 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
-	return (void *)__bus_to_virt(addr);
+	return (void *)__bus_to_virt((unsigned long)addr);
 }
 
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
