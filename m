From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:47:30 +0200
Subject: [PATCH v3 0/6] drm/rockchip: hdmi support for rk3328
Message-ID: <20180515134736.5824-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228/rk3229 and rk3328 socs started using a new type of hdmi-phy
from Innosilicon that resides completely separate from the dw-hdmi block
and gets accessed via mmio.

Additionally the rk3328 dw-hdmi does not report the vendor-phy type
but a different one instead, so add the possibility to override the
phy type when the glue driver knows better than the ip block itself.

changes in v3:
- split off phy driver into a separate series
- only allow forcing vendor phy type
- wording fixes and other nits

changes in v2:
- phy: prevent overflow in tmdsclk calculation
  as reported by Martin Cerveny
- phy: use unsigned long for all tmdsclk rate uses
- phy: simplify tmds rate calculation
- dropped patch exporting some dw-hdmi phy functions
  as a similar patch entered drm-misc already

Heiko Stuebner (6):
  drm/bridge: dw-hdmi: allow forcing vendor phy-type
  drm/rockchip: dw_hdmi: Allow outputs that don't need output switching
  dt-bindings: allow optional phys in Rockchip dw_hdmi binding
  drm/rockchip: dw_hdmi: allow including external phys
  drm/rockchip: dw_hdmi: store rockchip_hdmi reference in phy_data
    object
  drm/rockchip: dw_hdmi: add dw-hdmi support for the rk3328

 .../display/rockchip/dw_hdmi-rockchip.txt     |   3 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   4 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   | 130 +++++++++++++++++-
 include/drm/bridge/dw_hdmi.h                  |   1 +
 4 files changed, 134 insertions(+), 4 deletions(-)

-- 
2.17.0
