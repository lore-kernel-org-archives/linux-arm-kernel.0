From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 20 Nov 2015 14:22:03 +0000
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move rockchip to
 use it
Message-ID: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is v2 of the patchset trying to make drm_of_component_probe() cope with finding
both local crtc ports and remote encoder ones. Heiko St?bner was nice enough to test
an earlier version that was patched following Russell's suggestions on rk3288, but
I haven't seen any reports from iMX or Armada users.

Changelog:
 v2: Updated the drm_of_component_probe() comment to explain why the reference count
     is not dropped. Fixed the compare_port() function for rockchip as described by
     Russell.
 v1: Original submission. http://lists.freedesktop.org/archives/dri-devel/2015-November/094546.html

Liviu Dudau (2):
  drm: Improve drm_of_component_probe() to correctly handle ports and remote ports.
  drm/rockchip: Convert the probe function to the generic drm_of_component_probe()

 drivers/gpu/drm/armada/armada_drv.c         |  3 +-
 drivers/gpu/drm/drm_of.c                    | 19 ++++--
 drivers/gpu/drm/imx/imx-drm-core.c          |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 98 ++++++-----------------------
 include/drm/drm_of.h                        |  6 +-
 5 files changed, 40 insertions(+), 89 deletions(-)

-- 
2.6.2
