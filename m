From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat,  1 Apr 2017 19:35:20 +0800
Subject: [PATCH v2 0/9] drm: rockchip: Fix rockchip drm unbind crash error
Message-ID: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Verified on rk3399 chromebook kevin:
1/ stop ui && pkill -9 frecon
2/ unbind/bind drm

Changes in v2:
Fix some commit messages.

Jeffy Chen (9):
  drm: bridge: analogix: Detach panel when unbinding analogix dp
  drm: bridge: analogix: Unregister dp aux when unbinding
  drm: bridge: analogix: Destroy connector when unbinding
  drm/rockchip: cdn-dp: Don't try to release firmware when not loaded
  drm/rockchip: vop: Enable pm domain when resetting vop
  drm/rockchip: Reoder unload sequence
  drm/rockchip: Force disable all crtc when unload
  drm/rockchip: gem: Don't alloc/free gem buf before drm dev registered
  drm/rockchip: cdn-dp: Don't unregister audio dev when unbinding

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 +++
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 10 ++++---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  7 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  8 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 31 +++++++++++++++-------
 5 files changed, 44 insertions(+), 16 deletions(-)

-- 
2.1.4
