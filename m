From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  8 Jun 2017 12:51:59 +0100
Subject: [PATCH 0/8] io-pgtable lock removal
Message-ID: <cover.1496921366.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's the cleaned up nominally-final version of the patches everybody's
keen to see. #1 is just a non-critical thing-I-spotted-in-passing fix,
#2-#4 do some preparatory work (and bid farewell to everyone's least
favourite bit of code, hooray!), and #5-#8 do the dirty deed itself.

The branch I've previously shared has been updated too:

  git://linux-arm.org/linux-rm  iommu/pgtable

All feedback welcome, as I'd really like to land this for 4.13.

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
 drivers/iommu/io-pgtable-arm-v7s.c | 173 +++++++++++++++++++++------------
 drivers/iommu/io-pgtable-arm.c     | 190 ++++++++++++++++++++++++-------------
 drivers/iommu/io-pgtable.h         |   6 ++
 5 files changed, 268 insertions(+), 185 deletions(-)

-- 
2.12.2.dirty
