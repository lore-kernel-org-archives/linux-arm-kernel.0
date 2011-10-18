From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 Oct 2011 19:19:17 +0200
Subject: [PATCH 0/8 v3] ARM: DMA-mapping framework redesign
Message-ID: <1318958365-19120-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is another update on my attempt on DMA-mapping framework redesign.
I focused mainly on the IOMMU mapper for ARM DMA-mapping implementation.
DMA-mapping patches have been rebased onto Linux v3.1-rc9-next kernel
with CMA v16 patches already applied. I've also integrated the code
provided by Krishna Reddy and added the missing methods for IOMMU DMA
mapper. The code has been tested on Samsung Exynos4 board.

Here is the link to the initial version of the DMA-mapping redesign patches:
http://www.spinics.net/lists/linux-mm/msg21241.html

Second version of the patches:
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000571.html
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000577.html

TODO:
- start the discussion about chaning alloc_coherent into alloc_attrs in
dma_map_ops structure.

GIT tree will all the patches:
http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/dma-mapping-v4
git://git.infradead.org/users/kmpark/linux-2.6-samsung dma-mapping-v4

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:
Marek Szyprowski (8):
  ARM: dma-mapping: remove offset parameter to prepare for generic
    dma_ops
  ARM: dma-mapping: use asm-generic/dma-mapping-common.h
  ARM: dma-mapping: implement dma sg methods on top of any generic dma
    ops
  ARM: dma-mapping: move all dma bounce code to separate dma ops
    structure
  ARM: dma-mapping: remove redundant code and cleanup
  common: dma-mapping: change alloc/free_coherent method to more
    generic alloc/free_attrs
  ARM: dma-mapping: use alloc, mmap, free from dma_ops
  ARM: dma-mapping: add support for IOMMU mapper

 arch/arm/Kconfig                   |    9 +
 arch/arm/common/dmabounce.c        |   78 +++-
 arch/arm/include/asm/device.h      |    5 +
 arch/arm/include/asm/dma-iommu.h   |   35 ++
 arch/arm/include/asm/dma-mapping.h |  403 +++++------------
 arch/arm/mm/dma-mapping.c          |  869 +++++++++++++++++++++++++++++++-----
 arch/arm/mm/vmregion.h             |    2 +-
 include/linux/dma-attrs.h          |    1 +
 include/linux/dma-mapping.h        |   13 +-
 9 files changed, 973 insertions(+), 442 deletions(-)
 create mode 100644 arch/arm/include/asm/dma-iommu.h

-- 
1.7.1.569.g6f426
