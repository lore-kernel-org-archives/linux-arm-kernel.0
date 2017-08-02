From: anup.patel@broadcom.com (Anup Patel)
Date: Wed,  2 Aug 2017 11:08:29 +0530
Subject: [PATCH v4] FlexRM support in VFIO platform
Message-ID: <1501652310-3638-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset primarily adds Broadcom FlexRM reset module for
VFIO platform driver.

The patches are based on Linux-4.13-rc3 and can also be
found at flexrm-vfio-v4 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v3:
 - Improve "depends on" for Kconfig option
   VFIO_PLATFORM_BCMFLEXRM_RESET
 - Fix typo in pr_warn() called by
   vfio_platform_bcmflexrm_shutdown()
 - Return error from vfio_platform_bcmflexrm_shutdown()
   when FlexRM ring flush timeout happens

Changes since v2:
 - Remove PATCH1 because fixing VFIO no-IOMMU mode is
   a separate topic

Changes since v1:
 - Remove iommu_present() check in vfio_iommu_group_get()
 - Drop PATCH1-to-PATCH3 because IOMMU_CAP_BYPASS is not
   required
 - Move additional comments out of license header in
   vfio_platform_bcmflexrm.c

Anup Patel (1):
  vfio: platform: reset: Add Broadcom FlexRM reset module

 drivers/vfio/platform/reset/Kconfig                |   8 ++
 drivers/vfio/platform/reset/Makefile               |   1 +
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 100 +++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c

-- 
2.7.4
