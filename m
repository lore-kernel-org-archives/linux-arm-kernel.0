From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Mar 2015 00:21:21 +0100
Subject: [PATCH 0/3] add power-supply support to dw_hdmi
Message-ID: <1429128.MSqYm0qZ9p@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least the Rockchip variant of the dw_hdmi should control its supplying
regulators. A cursory glance at the imx manual didn't any equivalent there,
so I'm not sure if there are similar controllable regulators present.

Patch1 is only a small fix to keep {devm_}regulator_bulk_get quiet in
the deferring case and could go directly to the regulator tree, if ok.

Patch3 is the addition of the supplies to the rk3288 boards and I would
take it into my dts branch if patch2 gets deemed acceptable.


Heiko Stuebner (3):
  regulator: don't emit errors in {devm_}regulator_bulk_get when defering
  drm/bridge: dw-hdmi: support optional supply regulators
  ARM: dts: rockchip: add hdmi analog power supplies to rk3288 boards

 .../devicetree/bindings/drm/bridge/dw_hdmi.txt     |  5 ++++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  2 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  2 ++
 drivers/gpu/drm/bridge/dw_hdmi.c                   | 27 +++++++++++++++++++++-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |  3 ++-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 15 +++++++++++-
 drivers/regulator/core.c                           |  5 ++--
 drivers/regulator/devres.c                         |  5 ++--
 include/drm/bridge/dw_hdmi.h                       |  3 ++-
 9 files changed, 59 insertions(+), 8 deletions(-)

-- 
2.1.4
