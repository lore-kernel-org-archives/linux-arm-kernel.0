From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon, 11 Aug 2014 15:45:49 -0700
Subject: [PATCH v5 0/1] Add iommu map_sg/unmap_sg API
Message-ID: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch for adding map_sg/unmap_sg to the generic IOMMU API.

v4 -> v5:
* Simplified logic in map_sg on error
* Moved fallback to separate function for both map an unmap and pointed
  all drivers to these fallbacks.

v3 -> v4:
* Removed BUG_ON in both map_sg and unmap_sg
* Removed PAGE_ALIGN of length of mapping

v2 -> v3:
* Updated commit text
* Simplifed fallback code and fixed variable types in map_sg function.
* Renamed and changed arguments to map and unmap functions

v1 -> v2:
* Added support for "option" argument to unmap call. This can be used by
  IOMMU driver implentations to allow clients to signal to the driver not
  to do TLB invalidate for example.
* Added fallback in case iommu_{map,unmap}_range is called for an IOMMU driver
  that does not have these implemented.
* Rebased on top of Joerg's tree.
* Split out patch from the rest of the patches.


Olav Haugan (1):
  iommu-api: Add map_sg/unmap_sg functions

 drivers/iommu/amd_iommu.c      |  2 ++
 drivers/iommu/arm-smmu.c       |  2 ++
 drivers/iommu/exynos-iommu.c   |  2 ++
 drivers/iommu/intel-iommu.c    |  2 ++
 drivers/iommu/iommu.c          | 33 +++++++++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c     |  2 ++
 drivers/iommu/msm_iommu.c      |  2 ++
 drivers/iommu/omap-iommu.c     |  2 ++
 drivers/iommu/shmobile-iommu.c |  2 ++
 drivers/iommu/tegra-smmu.c     |  2 ++
 include/linux/iommu.h          | 44 ++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 95 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
