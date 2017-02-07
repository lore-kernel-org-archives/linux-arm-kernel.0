From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  7 Feb 2017 16:35:35 +0800
Subject: [PATCH v2 0/7] drm/rockchip: switch to drm_mm for support arm64 iommu
Message-ID: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some iommu patches on the series[0] "iommu/rockchip: Fix bugs and
enable on ARM64" already landed, So drm/rockchip related patches [1] and [2]
ready to landed, this series just rebase them to lastest drm-next.

And fix some bugs for drm/rockchip drm_mm

[0]: http://www.spinics.net/lists/arm-kernel/msg513781.html
[1]: https://patchwork.kernel.org/patch/9196367
[2]: https://patchwork.kernel.org/patch/9196369

Changes in v2:
Advices by Tomasz:
  add some fixes patches from chromeos project.

Mark Yao (2):
  drm/rockchip: gem: add mutex lock for drm mm
  drm/rockchip: gem: fixup iommu_map_sg error path

Shunqian Zheng (1):
  drm/rockchip: Use common IOMMU API to attach devices

Tomasz Figa (3):
  drm/rockchip: Do not use DMA mapping API if attached to IOMMU domain
  drm/rockchip: Fix the call to drm_gem_put_pages()
  drm/rockchip: Call drm_gem_object_release() to destroy GEM base

?rjan Eide (1):
  drm/rockchip: Respect page offset in IOMMU mmap

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 101 ++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 244 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   8 +
 4 files changed, 298 insertions(+), 61 deletions(-)

-- 
1.9.1
