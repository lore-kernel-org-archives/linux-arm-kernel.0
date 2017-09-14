From: hjc@rock-chips.com (Sandy Huang)
Date: Thu, 14 Sep 2017 11:43:14 +0800
Subject: [PATCH 0/3] Add support rockchip RGB output interface
Message-ID: <1505360594-196508-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add support some rockchip Soc like rv1108, the VOP can directly
output parallel and serial RGB data to panel or to conversion chip. So we add
this driver to probe encoder and connector to support this case.

Sandy Huang (3):
  dt-bindings: Add document for rockchip RGB output interface
  drm/rockchip: Add support for Rockchip Soc RGB output interface
  drm/rockchip: vop: Add more RGB output interface type

 .../bindings/display/rockchip/rockchip-rgb.txt     |  80 +++++
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   2 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c            | 327 +++++++++++++++++++++
 7 files changed, 422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c

-- 
2.7.4
