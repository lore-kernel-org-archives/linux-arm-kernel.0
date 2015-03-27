From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Mar 2015 17:19:46 +0000
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct iommu_ops
Message-ID: <20150327171946.GL1562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please can you pull the following IOMMU changes for 4.1? They move the
per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
IOMMUs such as the ARM SMMU to support different page sizes within a
given SoC.

Cheers,

Will

--->8

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/pgsize

for you to fetch changes up to 0232a7bfdab918a0cfdc7545abf09e359eb8c32c:

  iommu: of: enforce const-ness of struct iommu_ops (2015-03-20 17:39:34 +0000)

----------------------------------------------------------------
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
