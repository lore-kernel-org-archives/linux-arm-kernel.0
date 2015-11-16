From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 16 Nov 2015 14:44:51 +0000
Subject: [PATCH 0/2] Improve drm_of_component_probe() and move rockchip to use
 it
Message-ID: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

When I have introduced the drm_of_component_probe() function I have managed to
break rockchip's DRM driver as the compare_of() function had to match both local
crtc ports and remote encoder ones. As suggested by Russell King, I have now
enhanced the drm_of_component_probe() function to take two comparison functions,
and converted (again) rockchip driver to use it.

I would really like to get some Tested-By this time if possible from IMX, Armada
and Rockchip developers as I lack hardware to do that myself.

The only thing not implemented from Russell's suggestion list is the renaming of
the function into drm_kms_component_probe().

Best regards,
Liviu

Liviu Dudau (2):
  drm: Improve drm_of_component_probe() to correctly handle ports and remote ports.
  drm/rockchip: Convert the probe function to the generic drm_of_component_probe()

 drivers/gpu/drm/armada/armada_drv.c         |  3 +-
 drivers/gpu/drm/drm_of.c                    | 23 +++++--
 drivers/gpu/drm/imx/imx-drm-core.c          |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 98 ++++++-----------------------
 include/drm/drm_of.h                        |  6 +-
 5 files changed, 44 insertions(+), 89 deletions(-)

-- 
2.6.0
