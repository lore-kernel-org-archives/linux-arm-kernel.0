From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 14 Dec 2015 16:32:03 +0800
Subject: [PATCH v2 0/8] drm/rockchip: covert to support atomic API
Message-ID: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches coverting drm rockchip to atomic API, do some
cleanup and some fixes on atomic side.

TODO: fence is not support on current version.

Tested on rk3288 popmetal board.

All guys can test it with following url:
 test case: https://github.com/markyzq/libdrm.git atomictest
 kernel:
  https://github.com/markyzq/kernel-drm-rockchip.git drm-rockchip-next-12-11

Changes in v2:
- Optimization commit planes sequence.
- Get vblank count on atomic_begin to protect vblank event.
Advised by Daniel Stone
- Direct return -EINVAL when yuv address is not support, instead of adjust it.
- code formating and cleanup.
Advised by Thierry Reding & Daniel Vetter
- Hook mode_set into crtc enable instead of hack crtc enable on mode set.

v1: http://lists.freedesktop.org/archives/dri-devel/2015-November/095745.html

Mark Yao (8):
  drm/rockchip: Use new vblank api drm_crtc_vblank_*
  drm/rockchip: vop: replace dpms with enable/disable
  drm/rockchip: Convert to support atomic API
  drm/rockchip: Optimization vop mode set
  drm/rockchip: support atomic asynchronous commit
  drm/rockchip: direct config connecter gate and out_mode
  drm: bridge/dw_hdmi: add atomic API support
  drm/rockchip: dw_hdmi: use encoder enable function

 drivers/gpu/drm/bridge/dw_hdmi.c            |   23 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   14 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   21 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   19 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  112 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  775 +++++++++++----------------
 6 files changed, 480 insertions(+), 484 deletions(-)

-- 
1.7.9.5
