From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Jun 2017 16:53:49 +0100
Subject: [PATCH v2 0/8] io-pgtable lock removal
Message-ID: <cover.1498145008.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The feedback has been promising, so v2 is just a final update to cover
a handful of memory ordering and cosmetic tweaks that came up when Will
and I went through this offline.

Thanks,
Robin.


Robin Murphy (8):
  iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
  iommu/io-pgtable-arm: Improve split_blk_unmap
  iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
  iommu/io-pgtable: Introduce explicit coherency
  iommu/io-pgtable-arm: Support lockless operation
  iommu/io-pgtable-arm-v7s: Support lockless operation
  iommu/arm-smmu: Remove io-pgtable spinlock
  iommu/arm-smmu-v3: Remove io-pgtable spinlock

 drivers/iommu/arm-smmu-v3.c        |  36 ++-----
 drivers/iommu/arm-smmu.c           |  48 ++++------
 drivers/iommu/io-pgtable-arm-v7s.c | 179 +++++++++++++++++++++-------------
 drivers/iommu/io-pgtable-arm.c     | 191 ++++++++++++++++++++++++-------------
 drivers/iommu/io-pgtable.h         |   6 ++
 5 files changed, 274 insertions(+), 186 deletions(-)

-- 
2.12.2.dirty
