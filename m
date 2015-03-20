From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 16:50:31 +0000
Subject: [PATCH v2 0/3] Kill off pgsize_bitmap field from struct iommu_ops
Message-ID: <1426870234-12910-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version two of the patches originally posted here:

  http://comments.gmane.org/gmane.linux.kernel.iommu/8993

Changes since v1 include:

  * Move the priv removal code into its own patch
  * Fixed bitmap definition for ipmmu-vmsa.c
  * Added acks

Comments welcome,

Will

--->8

Robin Murphy (1):
  iommu: of: enforce const-ness of struct iommu_ops

Will Deacon (2):
  iommu: remove unused priv field from struct iommu_ops
  iommu: move pgsize_bitmap from struct iommu_ops to struct iommu_domain

 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  6 +++---
 arch/arm64/include/asm/dma-mapping.h |  3 ++-
 drivers/iommu/amd_iommu.c            |  2 +-
 drivers/iommu/arm-smmu.c             | 12 +++++-------
 drivers/iommu/exynos-iommu.c         |  3 ++-
 drivers/iommu/intel-iommu.c          |  2 +-
 drivers/iommu/iommu.c                | 16 ++++++++--------
 drivers/iommu/ipmmu-vmsa.c           |  2 +-
 drivers/iommu/msm_iommu.c            |  3 ++-
 drivers/iommu/of_iommu.c             | 12 ++++++------
 drivers/iommu/omap-iommu.c           |  3 ++-
 drivers/iommu/rockchip-iommu.c       |  2 +-
 drivers/iommu/shmobile-iommu.c       |  2 +-
 drivers/iommu/tegra-gart.c           |  2 +-
 drivers/iommu/tegra-smmu.c           |  3 +--
 drivers/of/platform.c                |  2 +-
 drivers/vfio/vfio_iommu_type1.c      |  2 +-
 include/linux/dma-mapping.h          |  2 +-
 include/linux/iommu.h                |  6 +-----
 include/linux/of_iommu.h             |  8 ++++----
 21 files changed, 46 insertions(+), 49 deletions(-)

-- 
2.1.4
