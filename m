From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Wed, 15 Jun 2016 20:04:39 +0800
Subject: [PATCH v3 0/6] fix bugs; enable iommu for ARM64
Message-ID: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches mainly for ARM64 supporting.
To do this, it first add virtual iommu slave device which DRM can attach to,
convert DRM driver to use common iommu API instead of the ARM32
functions, and then use DMA API in iommu driver to map, to flush cache.

Mainly changes of V3:
    - Instead of registering virtual iommu in DTS, V3
      creates a iommu when attaching.
    - Fix some bugs according to Tomasz's comments,
      most of them are offline, locally.

Shunqian Zheng (3):
  iommu/rockchip: support virtual iommu slave device
  drm: rockchip: use common iommu api to attach iommu
  iommu/rockchip: use DMA API to map, to flush cache

Simon Xue (3):
  iommu/rockchip: fix devm_{request,free}_irq parameter
  iommu/rockchip: add map_sg callback for rk_iommu_ops
  iommu/rockchip: enable rockchip iommu on ARM64 platform

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 112 ++++++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 drivers/iommu/Kconfig                       |   2 +-
 drivers/iommu/rockchip-iommu.c              | 251 ++++++++++++++++++++++------
 4 files changed, 273 insertions(+), 93 deletions(-)

-- 
1.9.1
