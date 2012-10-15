From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Oct 2012 16:03:50 +0200
Subject: [RFC 0/2] DMA-mapping & IOMMU - physically contiguous allocations
Message-ID: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Some devices, which have IOMMU, for some use cases might require to
allocate a buffers for DMA which is contiguous in physical memory. Such
use cases appears for example in DRM subsystem when one wants to improve
performance or use secure buffer protection.

I would like to ask if adding a new attribute, as proposed in this RFC
is a good idea? I feel that it might be an attribute just for a single
driver, but I would like to know your opinion. Should we look for other
solution?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


Marek Szyprowski (2):
  common: DMA-mapping: add DMA_ATTR_FORCE_CONTIGUOUS attribute
  ARM: dma-mapping: add support for DMA_ATTR_FORCE_CONTIGUOUS attribute

 Documentation/DMA-attributes.txt |    9 +++++++++
 arch/arm/mm/dma-mapping.c        |   41 ++++++++++++++++++++++++++++++--------
 include/linux/dma-attrs.h        |    1 +
 3 files changed, 43 insertions(+), 8 deletions(-)

-- 
1.7.9.5
