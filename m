From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Feb 2016 10:47:28 +0530
Subject: [PATCH v2 0/4] iommu/arm-smmu: misc fixes for SMMUv1/SMMUv2
Message-ID: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The intention behind this patchset is to allow usage of IOMMU based
DMA mappings for 32bit devices. It is based on '4.5-rc3' tag of linux
mainline tree and Robin's SMMU patchset "[PATCH 0/4] Miscellaneous
ARM SMMU patches".

This patchset and its dependent patches are available in smmu_v2
branch of https://github.com/Broadcom/arm64-linux.git

All patches have been tested on Broadcom SoCs having SMMU-500.

Anup Patel (3):
  iommu/arm-smmu: Invoke DT probe from arm_smmu_of_setup()
  of: iommu: Increment DT node refcount in of_iommu_set_ops()
  iommu/arm-smmu: Add stub of_xlate() operation in SMMUv1/SMMUv2 driver

Sricharan R (1):
  iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE

 drivers/iommu/arm-smmu.c | 52 ++++++++++++++++++++++++++++++++++++------------
 drivers/iommu/of_iommu.c |  1 +
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
1.9.1
