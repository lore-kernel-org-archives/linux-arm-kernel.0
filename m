From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 22 Jan 2016 09:37:03 +0800
Subject: [GIT PULL] drm/rockchip: fixes
Message-ID: <56A187BF.5060906@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave

Here are some fixes for drm/rockchip, these fixes base on drm-next.

These fixes works on my popmetal(rk3288) board.

About patch: drm/atomic-helper: Export framebuffer_changed()
Daniel Vetter ack for merging it through rockchip git trees, so 
framebuffer_changed() can be reused by drm/rockchip.

All others looks good, so I'd like you can land them.

Thanks.

The following changes since commit 1df59b8497f47495e873c23abd6d3d290c730505:

   Merge tag 'drm-intel-next-fixes-2016-01-14' of 
git://anongit.freedesktop.org/drm-intel into drm-next (2016-01-18 
07:02:19 +1000)

are available in the git repository at:

   https://github.com/markyzq/kernel-drm-rockchip.git 
drm-rockchip-next-fixes-2016-01-22

for you to fetch changes up to f0442df2156a2171e40f1643c60103e6333f4e7e:

   drm/rockchip: respect CONFIG_DRM_FBDEV_EMULATION (2016-01-22 08:45:31 
+0800)

----------------------------------------------------------------
Andrzej Hajda (1):
       drm/rockchip/dsi: fix handling mipi_dsi_pixel_format_to_bpp result

John Keeping (5):
       drm/rockchip: vop: fix mask when updating interrupts
       drm/atomic-helper: Export framebuffer_changed()
       drm/rockchip: don't wait for vblank if fb hasn't changed
       drm/rockchip: explain why we can't wait_for_vblanks
       drm/rockchip: respect CONFIG_DRM_FBDEV_EMULATION

Mark Yao (3):
       drm/rockchip: Don't build rockchip_drm_vop as modules
       drm/rockchip: cleanup unnecessary export symbol
       drm/rockchip: fix wrong pitch/size using on gem

  drivers/gpu/drm/drm_atomic_helper.c           |   24 
++++++++++++++++++++----
  drivers/gpu/drm/rockchip/Makefile             |    8 ++++----
  drivers/gpu/drm/rockchip/dw-mipi-dsi.c        |    3 ++-
  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    4 ----
  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |   24 
+++++++++++++++++++++---
  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.h |   11 +++++++++++
  drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |    9 ++-------
  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |   16 +++++++++-------
  include/drm/drm_atomic_helper.h               |    4 ++++
  9 files changed, 73 insertions(+), 30 deletions(-)

-- 
?ark Yao
