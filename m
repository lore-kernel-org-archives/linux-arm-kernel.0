From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 31 Jul 2017 17:49:28 +0800
Subject: [PATCH 0/6] drm/rockchip: Some fixes
Message-ID: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some fixes port from rockchip_linux project[0],

Tested on rk3399 and rk3288 board.

[0]: https://github.com/rockchip-linux/kernel

Mark Yao (6):
  drm/rockchip: vop: no need wait vblank on crtc enable
  drm/rockchip: vop: fix iommu page fault when resume
  drm/rockchip: vop: fix NV12 video display error
  drm/rockchip: vop: round_up pitches to word align
  drm/rockchip: vop: report error when check resource error
  drm/rockchip: fix race with kms hotplug and fbdev

 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 77 ++++++++---------------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  3 ++
 3 files changed, 24 insertions(+), 58 deletions(-)

-- 
1.9.1
