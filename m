From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  1 Dec 2015 11:26:22 +0800
Subject: [RFC PATCH 0/9] drm/rockchip: covert to support atomic API
Message-ID: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches coverting drm rockchip to atomic API, do some
cleanup and some fixes on atomic side.

TODO: fence is not support on current version.

Tested on rk3288 popmetal board.

All guys can test it with following url:
 test case: https://github.com/markyzq/libdrm.git atomictest
 kernel: https://github.com/markyzq/kernel-drm-rockchip.git drm-rockchip-2015-11-31

Mark Yao (9):
  drm/rockchip: vop: replace dpms with enable/disable
  drm/rockchip: Use new vblank api drm_crtc_vblank_*
  drm/rockchip: Convert to support atomic API
  drm/rockchip: support atomic asynchronous commit
  drm/rockchip: Optimization vop mode set
  drm/rockchip: direct config connecter gate and out_mode
  drm/rockchip: force enable vop when do mode setting
  drm: bridge/dw_hdmi: Covert to support atomic API
  drm/rockchip: dw_hdmi: use encoder enable function

 drivers/gpu/drm/bridge/dw_hdmi.c            |    6 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   14 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   18 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |    9 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   99 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  735 +++++++++++----------------
 6 files changed, 413 insertions(+), 468 deletions(-)

-- 
1.7.9.5
