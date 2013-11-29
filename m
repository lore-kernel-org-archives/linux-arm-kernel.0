From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:15:46 +0000
Subject: [PATCH 0/4] iommu: arm/smmu: current updates for 3.14
Message-ID: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are a few patches I have for the arm/smmu driver that I'm
targetting for 3.14. The main changes are adding an IOMMU_EXEC flag to
allow for non-executable mappings (in response to work that RMK has done
for the CPU-side of things) and automatically adding devices to an IOMMU
group.

I suspect there will be additional patches from Andreas before I put
together my pull request before Christmas.

All comments welcome,

Will


Antonios Motakis (1):
  iommu/arm-smmu: add devices attached to the SMMU to an IOMMU group

Will Deacon (3):
  iommu/arm-smmu: use VA_BITS to determine arm64 virtual address space
  iommu: add IOMMU_EXEC flag for safely allowing XN mappings
  iommu/arm-smmu: add support for IOMMU_EXEC

 drivers/iommu/arm-smmu.c | 33 ++++++++++++++++++++++++++-------
 include/linux/iommu.h    |  7 ++++---
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
1.8.2.2
