From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Feb 2012 19:58:37 +0100
Subject: [PATCHv6 0/7] ARM: DMA-mapping framework redesign
Message-ID: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is another update on my works DMA-mapping framework redesign for
ARM architecture. It includes a few minor cleanup and fixes since the
last version posted by the end of December 2011. This patch series is
now based on the generic, cross-arch dma-mapping redesign patches posted
in the "[PATCH 00/14] DMA-mapping framework redesign preparation"
thread: http://www.spinics.net/lists/linux-sh/msg09777.html

All patches have been now rebased onto v3.3-rc2 kernel.

All the code has been tested on Samsung Exynos4 'UniversalC210' board
with IOMMU driver posted by KyongHo Cho.


History of the development:

v1: (initial version of the DMA-mapping redesign patches):
http://www.spinics.net/lists/linux-mm/msg21241.html

v2:
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000571.html
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000577.html

v3:
http://www.spinics.net/lists/linux-mm/msg25490.html

v4 and v5:
http://www.spinics.net/lists/arm-kernel/msg151147.html
http://www.spinics.net/lists/arm-kernel/msg154889.html

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (7):
  ARM: dma-mapping: remove offset parameter to prepare for generic
    dma_ops
  ARM: dma-mapping: use asm-generic/dma-mapping-common.h
  ARM: dma-mapping: implement dma sg methods on top of any generic dma
    ops
  ARM: dma-mapping: move all dma bounce code to separate dma ops
    structure
  ARM: dma-mapping: remove redundant code and cleanup
  ARM: dma-mapping: use alloc, mmap, free from dma_ops
  ARM: dma-mapping: add support for IOMMU mapper

 arch/arm/Kconfig                   |    9 +
 arch/arm/common/dmabounce.c        |   78 +++-
 arch/arm/include/asm/device.h      |    4 +
 arch/arm/include/asm/dma-iommu.h   |   34 ++
 arch/arm/include/asm/dma-mapping.h |  404 +++++------------
 arch/arm/mm/dma-mapping.c          |  897 ++++++++++++++++++++++++++++++------
 arch/arm/mm/vmregion.h             |    2 +-
 7 files changed, 980 insertions(+), 448 deletions(-)
 create mode 100644 arch/arm/include/asm/dma-iommu.h

-- 
1.7.1.569.g6f426
