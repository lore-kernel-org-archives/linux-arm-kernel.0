From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 18 Jun 2015 15:49:24 +0800
Subject: [PATCH 0/6] drm/rockchip: support yuv overlay and plane scale
Message-ID: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches are used for yuv image overlay display.

Rockchip vop support NV11, NV16, NV24 yuv format,
and can scale the image scale 1/8 to 8.

Mark Yao (6):
  drm/rockchip: import dma_buf to gem
  drm/rockchip: vop: optimize virtual stride calculate
  drm/rockchip: vop: fix yuv plane support
  drm/rockchip: vop: support plane scale
  drm/rockchip: vop: switch cursor plane to window 3
  drm/rockchip: vop: default enable win2/3 area0 bit

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |   45 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |    5 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  445 ++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   96 ++++++
 5 files changed, 581 insertions(+), 11 deletions(-)

-- 
1.7.9.5
