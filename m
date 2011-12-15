From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Thu, 15 Dec 2011 15:18:28 +0200
Subject: [PATCH v2 0/2] ARM: IOMMU: tegra: iommu_ops for GART driver
Message-ID: <1323955108-7317-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds support for iommu_ops for Tegra20/30.

They are not expected to be merged now since it requres some other
components for more testing but are posted for review. This was simply
tested with the DMA API without real buffer access from device side,
only with allocation/mapping/freeing from MPU side.

This was originally developed with Tegra specific IOMMU API in:
  git://nv-tegra.nvidia.com/linux-2.6.git.

v1: https://lkml.org/lkml/2011/11/17/111

Hiroshi DOYU (2):
  [RFC] ARM: IOMMU: Tegra20: iommu_ops for GART driver
  [RFC] ARM: IOMMU: Tegra30: iommu_ops for SMMU driver

 arch/arm/mach-tegra/include/mach/smmu.h |   63 ++
 drivers/iommu/Kconfig                   |   22 +
 drivers/iommu/Makefile                  |    2 +
 drivers/iommu/tegra-gart.c              |  451 ++++++++++++++
 drivers/iommu/tegra-smmu.c              | 1027 +++++++++++++++++++++++++++++++
 5 files changed, 1565 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/smmu.h
 create mode 100644 drivers/iommu/tegra-gart.c
 create mode 100644 drivers/iommu/tegra-smmu.c

-- 
1.7.5.4
