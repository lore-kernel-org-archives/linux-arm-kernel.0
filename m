From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  5 Apr 2017 16:29:18 +0800
Subject: [PATCH v3 0/9] drm: rockchip: Fix rockchip drm unbind crash error
Message-ID: <1491380967-28570-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Verified on rk3399 chromebook kevin:
1/ stop ui && pkill -9 frecon
2/ unbind/bind drm

Changes in v3:
Address Sean Paul <seanpaul@chromium.org>'s comments.
Update commit message.
Address Sean Paul <seanpaul@chromium.org>'s comments.
Update commit message.
Address Daniel Vetter <daniel@ffwll.ch>'s comments.
Update commit message.
Address Daniel Vetter <daniel@ffwll.ch>'s comments.
Update commit message.
Update commit message.

Changes in v2:
Fix some commit messages.

Jeffy Chen (9):
  drm: bridge: analogix: Detach panel when unbinding analogix dp
  drm: bridge: analogix: Unregister dp aux when unbinding
  drm: bridge: analogix: Destroy connector when unbinding
  drm/rockchip: cdn-dp: Don't try to release firmware when not loaded
  drm/rockchip: vop: Enable pm domain before vop_initial
  drm/rockchip: Reoder drm bind/unbind sequence
  drm/rockchip: Shutdown all crtcs when unbinding drm
  drm/rockchip: gem: Don't alloc/free gem buf when dev_private is
    invalid
  drm/rockchip: cdn-dp: Don't unregister audio dev when unbinding

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 ++
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 10 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        | 50 ++++++++++++----------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  8 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 29 +++++++++----
 5 files changed, 66 insertions(+), 35 deletions(-)

-- 
2.1.4
