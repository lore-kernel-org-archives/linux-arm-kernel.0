From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 19 Jul 2017 15:03:53 +0530
Subject: [PATCH 0/5] FlexRM support in VFIO platform
Message-ID: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset primarily adds Broadcom FlexRM reset module for
VFIO platform driver. We also have minor improvments in IOMMU
and VFIO driver to allow VFIO no-IOMMU mode access to FlexRM.

The patches are based on Linux-4.13-rc1 and can also be
found at flexrm-vfio-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Anup Patel (5):
  iommu: Add capability IOMMU_CAP_BYPASS
  iommu/arm-smmu: add IOMMU_CAP_BYPASS to the ARM SMMU driver
  iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM SMMUv3 driver
  vfio: Allow No-IOMMU mode for IOMMUs with bypass capability
  vfio: platform: reset: Add Broadcom FlexRM reset module

 drivers/iommu/arm-smmu-v3.c                        |  2 +
 drivers/iommu/arm-smmu.c                           |  2 +
 drivers/vfio/platform/reset/Kconfig                |  9 +++
 drivers/vfio/platform/reset/Makefile               |  1 +
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 91 ++++++++++++++++++++++
 drivers/vfio/vfio.c                                | 13 +++-
 include/linux/iommu.h                              |  4 +
 7 files changed, 119 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c

-- 
2.7.4
