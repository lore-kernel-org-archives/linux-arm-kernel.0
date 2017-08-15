From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 15 Aug 2017 11:49:14 +0800
Subject: [PATCH v5 0/3] Add support Rockchip Soc LVDS
Message-ID: <1502768955-176510-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[0]: https://github.com/RockchipOpensourceCommunity/popmetal-kernel-3.14
  ]: http://lists.infradead.org/pipermail/linux-rockchip/2015-April/002830.html

Changes:
- Update rockchip_lvds_encoder_helper_funcs to atomic API
- Add bridge function for RGB/LVDS convert to other output type
- Fix some unreasonable define
- Adapter to the latest rockchip DRM driver framework
- Add pinctrl for RGB output type
- Reseved some define for rockchip next Soc

Sandy Huang (3):
  dt-bindings: display: Add Document for Rockchip Soc LVDS
  ARM: dts: Add LVDS info for rk3288
  drm/rockchip: Add support for Rockchip Soc LVDS

 .../bindings/display/rockchip/rockchip-lvds.txt    | 105 ++++
 arch/arm/boot/dts/rk3288.dtsi                      |  52 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_lvds.c           | 599 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.h           | 109 ++++
 8 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.h

-- 
2.7.4
