From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  4 Dec 2015 17:52:57 +0000
Subject: [PATCH 0/5] io-pgtable fixes + ARM short-descriptor format
Message-ID: <cover.1449246988.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been tested on an MMU-500 Fast Model, with the ARM SMMU driver
hacked up to force short-descriptor at stage 1 - doing it properly needs
more work to decouple the context format from the kernel bit-ness. Since
I didn't want to delay getting this lot posted, that can come later.

Thanks,
Robin.

Robin Murphy (5):
  iommu/io-pgtable-arm: Avoid dereferencing bogus PTEs
  iommu/io-pgtable: Indicate granule for TLB maintenance
  iommu/arm-smmu: Invalidate TLBs properly
  iommu/io-pgtable: Make io_pgtable_ops_to_pgtable() macro common
  iommu/io-pgtable: Add ARMv7 short descriptor support

 drivers/iommu/Kconfig              |  19 +
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/arm-smmu-v3.c        |   2 +-
 drivers/iommu/arm-smmu.c           |  21 +-
 drivers/iommu/io-pgtable-arm-v7s.c | 836 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c     |  38 +-
 drivers/iommu/io-pgtable.c         |   3 +
 drivers/iommu/io-pgtable.h         |  20 +-
 drivers/iommu/ipmmu-vmsa.c         |   4 +-
 9 files changed, 916 insertions(+), 28 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c

-- 
1.9.1
