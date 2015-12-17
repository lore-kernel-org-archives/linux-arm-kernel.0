From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 17 Dec 2015 20:50:56 +0000
Subject: [PATCH v2 0/3] io-pgtable ARM short descriptor format
Message-ID: <cover.1450383740.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

A few small changes in io-pgtable-arm-v7s.c to address Yong's comments:
- Add a comment explaining "cont".
- Keep kmemleak quiet.
- Make the loop in arm_v7s_iova_to_phys, and correspondingly the
  level test in the ARM_V7S_PTE_IS_TABLE macro, more sane.

I've dropped the fixes which Will has queued already, even if it does
mean my own semicolons will never get to see the light of day :(

I'm posting patches 2 and 3 as a series with this as they're inspired
by the sync issue raised on v1 and touch the code in patch 1, but those
two are really more of an RFC idea than intended 4.5 material.

Robin.

Robin Murphy (3):
  iommu/io-pgtable: Add ARMv7 short descriptor support
  iommu/io-pgtable: Add helper functions for TLB ops
  iommu/io-pgtable: Avoid redundant TLB syncs

 drivers/iommu/Kconfig              |  19 +
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c | 840 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c     |  21 +-
 drivers/iommu/io-pgtable.c         |   5 +-
 drivers/iommu/io-pgtable.h         |  37 +-
 6 files changed, 909 insertions(+), 14 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c

-- 
1.9.1
