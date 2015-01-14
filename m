From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 19:13:20 +0000
Subject: [PATCH v2 0/3] DMA teardown fixes
Message-ID: <1421262803-21003-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

Here's v2 of the DMA teardown fixes I posted on Monday:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315366.html

The only change since v1 is that I've moved the conversion to using
to_dma_iommu_mapping into a separate patch and converted the whole of
dma-mapping.c in the process (suggested by Laurent).

I plan to send patches 2 and 3 via rmk and I hope that arm-soc can pick
up the first one.

Will

--->8

Will Deacon (3):
  of/platform: teardown DMA mappings on device destruction
  ARM: dma-mapping: don't detach devices without an IOMMU during
    teardown
  ARM: dma-mapping: use to_dma_iommu_mapping instead of accessing
    archdata

 arch/arm/mm/dma-mapping.c | 25 ++++++++++++++-----------
 drivers/of/platform.c     |  1 +
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.1.4
