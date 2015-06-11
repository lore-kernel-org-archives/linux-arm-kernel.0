From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Jun 2015 16:54:20 +0100
Subject: [PATCH v2 0/4] arm64: IOMMU-backed DMA mapping
Message-ID: <cover.1434036796.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's a quick repost of [1] with a couple of minor fixes:
- fix scatterlist dma_len for segments with nonzero offset
- adjust the bus notifier priority with a less silly value

The branch at [2] has been updated as well.

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/9721
[2]:git://linux-arm.org/linux-rm iommu/dma

Robin Murphy (4):
  iommu/iova: Avoid over-allocating when size-aligned
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/device.h      |   3 +
 arch/arm64/include/asm/dma-mapping.h |  25 +-
 arch/arm64/mm/dma-mapping.c          | 357 ++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 560 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c          |   2 +
 drivers/iommu/iova.c                 |  23 +-
 include/linux/dma-iommu.h            |  94 ++++++
 10 files changed, 1051 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
