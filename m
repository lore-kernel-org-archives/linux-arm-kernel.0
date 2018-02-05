From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:26 +0100
Subject: [PATCH 0/9] drm/rockchip: hdmi support for rk3328
Message-ID: <20180205143435.4723-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228/rk3229 and rk3328 socs started using a new type of hdmi-phy
from Innosilicon that resides completely separate from the dw-hdmi block
and gets accessed via mmio.

Additionally the rk3328 dw-hdmi does not report the vendor-phy type
but a different one instead, so add the possibility to override the
phy type when the glue driver knows better than the ip block itself.


I've put both the phy driver and dw-hdmi changes into one series just
to showcase how everything comes together, but would of course still
expect things to go through the separate phy and drm trees once deemed
ready.


Algea Cao (1):
  drm/bridge: dw-hdmi: export hotplug functions

Heiko Stuebner (6):
  drm/bridge: dw-hdmi: allow overriding of phy-type reading
  drm/rockchip: dw_hdmi: Allow outputs that don't need output switching
  dt-bindings: allow optional phys in Rockchip dw_hdmi binding
  drm/rockchip: dw_hdmi: allow including external phys
  drm/rockchip: dw_hdmi: store rockchip_hdmi reference in phy_data
    object
  drm/rockchip: dw_hdmi: add dw-hdmi support for the rk3328

Zheng Yang (2):
  dt-bindings: add binding for Rockchip hdmi phy using an Innosilicon IP
  phy: add Rockchip Innosilicon hdmi phy

 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |    3 +
 .../bindings/phy/phy-rockchip-inno-hdmi.txt        |   42 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   15 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  130 ++-
 drivers/phy/rockchip/Kconfig                       |    7 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 1221 ++++++++++++++++++++
 include/drm/bridge/dw_hdmi.h                       |    7 +-
 8 files changed, 1417 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c

-- 
2.15.1
