From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Aug 2016 14:05:38 +0100
Subject: [PATCH 0/4] iommu/arm-smmu: Fixes for 4.8
Message-ID: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's the current pile of ARM SMMU fixes I have queued for 4.8. I plan
to send a pull to Joerg tomorrow afternoon.

Cheers,

Will

--->8

Robin Murphy (1):
  iommu/io-pgtable-arm-v7s: Fix attributes when splitting blocks

Will Deacon (3):
  iommu/arm-smmu: Fix CMDQ error handling
  iommu/arm-smmu: Disable stalling faults for all endpoints
  iommu/arm-smmu: Don't BUG() if we find aborting STEs with
    disable_bypass

 drivers/iommu/arm-smmu-v3.c        |  7 +++++--
 drivers/iommu/arm-smmu.c           | 34 +++++++---------------------------
 drivers/iommu/io-pgtable-arm-v7s.c |  4 +++-
 3 files changed, 15 insertions(+), 30 deletions(-)

-- 
2.1.4
