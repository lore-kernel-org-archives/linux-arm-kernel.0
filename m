From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 26 Jun 2015 18:07:24 +0800
Subject: [PATCH v2 0/5] drm/rockchip: support yuv overlay and plane scale
Message-ID: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patches are used for yuv image overlay display.

Rockchip vop support NV11, NV16, NV24 yuv format,
and can scale the image scale 1/8 to 8.

Changes in v2:
- Uv buffer not support odd offset, align it.
- Fix error display when move yuv image. 
- Fix scale dest info. 

Mark Yao (5):
  drm/rockchip: vop: optimize virtual stride calculate
  drm/rockchip: vop: fix yuv plane support
  drm/rockchip: vop: support plane scale
  drm/rockchip: vop: switch cursor plane to window 3
  drm/rockchip: default enable win2/3 area0 bit

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  467 ++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   96 ++++++
 2 files changed, 551 insertions(+), 12 deletions(-)

-- 
1.7.9.5
