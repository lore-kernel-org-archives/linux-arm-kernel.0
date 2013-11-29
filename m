From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:14:32 +0000
Subject: [PATCH 0/3] iommu: arm/smmu: fixes for 3.13
Message-ID: <1385727275-19082-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are a few fixes for the arm/smmu driver. I think the main one is
fixing the locking around page-table walking/creating, which is probably
a candidate for stable.

All comments welcome,

Will


Wei Yongjun (1):
  iommu/arm-smmu: fix error return code in arm_smmu_device_dt_probe()

Will Deacon (2):
  iommu/arm-smmu: use mutex instead of spinlock for locking page tables
  iommu/arm-smmu: remove potential NULL dereference on mapping path

 drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

-- 
1.8.2.2
