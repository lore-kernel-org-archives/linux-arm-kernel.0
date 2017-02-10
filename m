From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 10 Feb 2017 14:29:33 +0800
Subject: [PATCH v3 0/2] drm/rockchip: switch to drm_mm for support arm64 iommu
Message-ID: <1486708175-23857-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some iommu patches on the series[0] "iommu/rockchip: Fix bugs and
enable on ARM64" already landed, So drm/rockchip related patches [1] and [2]
ready to landed, this series just rebase them to lastest drm-next.

Thanks Heiko's Tested-by on rk3288 and rk3399 platform.

Changes in v3:
Advices by Tomasz and Thierry:
  merge fixes into origin patch.

Changes in v2:
Advices by Tomasz:
  add some fixes patches from chromeos project.

Shunqian Zheng (1):
  drm/rockchip: Use common IOMMU API to attach devices

Tomasz Figa (1):
  drm/rockchip: Do not use DMA mapping API if attached to IOMMU domain

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 101 ++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 244 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   8 +
 4 files changed, 298 insertions(+), 61 deletions(-)

-- 
1.9.1
