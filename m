From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 16 Jun 2014 01:35:33 +0200
Subject: [PATCH 0/6] pinctrl: rockchip: support rk3288
Message-ID: <1887108.ECBDVhibgn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the rk3288 SoC.

The first patch generalizes the gpio-only handling of the rk3188 into a
general quirk-handling making it possible to deprecate the special bank
compatible and also to add quirks of later SoCs.

Patches 2 to 5 enable the driver to handle the quirks of rk3288 and
patch 6 then simply adds the description of the rk3288 banks.

Tested on a rk3288-evb and on a rk3188-radxarock with both the
deprecated and new regular notation for bank0.

Heiko Stuebner (6):
  pinctrl: rockchip: generalize bank-quirks
  pinctrl: rockchip: precalculate iomux offsets
  pinctrl: rockchip: add support for 4bit wide iomux settings
  pinctrl: rockchip: enable iomuxes from pmu space
  pinctrl: rockchip: support unrouted iomuxes per bank
  pinctrl: rockchip: add support for rk3288 pin-controller

 .../bindings/pinctrl/rockchip,pinctrl.txt          |   4 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 251 +++++++++++++++++----
 2 files changed, 215 insertions(+), 39 deletions(-)

-- 
1.9.0
