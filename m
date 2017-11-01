From: hjc@rock-chips.com (Sandy Huang)
Date: Wed,  1 Nov 2017 15:52:33 +0800
Subject: [PATCH v4 0/4] Add support rockchip RGB output interface
Message-ID: <1509522753-118639-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add support rockchip RGB output, Some Rockchip CRTCs, like rv1108,
can directly output parallel and serial RGB data to panel or to conversion chip.
So we add this driver to probe encoder and connector to support this case.

Sandy Huang (4):
  devicetree/bindings: display: Add doucument for RGB panels
  devicetree/bindings: display: Add document for rockchip RGB output
  drm/rockchip: Add support for Rockchip Soc RGB output interface
  drm/rockchip: vop: Add more RGB output interface type

 .../bindings/display/panel/panel-rgb.txt           | 116 +++++++
 .../bindings/display/rockchip/rockchip-rgb.txt     |  72 +++++
 drivers/gpu/drm/rockchip/Kconfig                   |  11 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   2 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c            | 344 +++++++++++++++++++++
 8 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-rgb.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c

-- 
2.7.4
