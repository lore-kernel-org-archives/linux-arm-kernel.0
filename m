From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Wed,  8 Jun 2016 21:26:25 +0800
Subject: [PATCH v2 0/7] fix bugs; enable iommu for ARM64
Message-ID: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches mainly for ARM64 supporting.
To do this, it first add virtual iommu slave device which DRM can attach to,
convert DRM driver to use common iommu API instead of the ARM32
functions, and then use DMA API in iommu driver to map, to flush cache.

The v2 patches make a lot changes vs v1, so please forget the v1.

Shunqian Zheng (4):
  iommu/rockchip: support virtual iommu slave device
  ARM: dts: rockchip: add virtual iommu for display
  drm: rockchip: use common iommu api to attach iommu
  iommu/rockchip: use DMA API to map, to flush cache

Simon Xue (3):
  iommu/rockchip: fix devm_{request,free}_irq parameter
  iommu/rockchip: add map_sg callback for rk_iommu_ops
  iommu/rockchip: enable rockchip iommu on ARM64 platform

 arch/arm/boot/dts/rk3288.dtsi               |   6 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 130 ++++++++++++++++--------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 drivers/iommu/Kconfig                       |   2 +-
 drivers/iommu/rockchip-iommu.c              | 151 ++++++++++++++++++----------
 5 files changed, 193 insertions(+), 97 deletions(-)

-- 
1.9.1
