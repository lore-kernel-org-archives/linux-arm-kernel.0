From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:01:07 +0800
Subject: [PATCH v3 0/8] drm/rockchip: covert to support atomic API
Message-ID: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches coverting drm rockchip to atomic API, do some
cleanup and some fixes on atomic side.

TODO: fence is not support on current version.

Tested on rk3288 popmetal board.

All guys can test it with following url:
 test case: https://github.com/markyzq/libdrm.git atomictest
 kernel:
  https://github.com/markyzq/kernel-drm-rockchip.git drm-rockchip-next-12-17

Changes in v3:
Reported by kbuild test robot
- fix rockchip_crtc_wait_for_update undefined when build drm rockchip as modules.

Changes in v2:
- Optimization commit planes sequence.
- Get vblank count on atomic_begin to protect vblank event.
Advised by Daniel Stone
- Direct return -EINVAL when yuv address is not support, instead of adjust it.
- code formating and cleanup.
Advised by Thierry Reding & Daniel Vetter
- Hook mode_set into crtc enable instead of hack crtc enable on mode set.

v2: http://www.spinics.net/lists/arm-kernel/msg468423.html
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
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   20 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  123 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  782 +++++++++++----------------
 6 files changed, 495 insertions(+), 488 deletions(-)

-- 
1.7.9.5
