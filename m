From: david.wu@rock-chips.com (David Wu)
Date: Wed,  9 Aug 2017 20:07:43 +0800
Subject: [PATCH v4 00/12] Add the internal phy support
Message-ID: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228 and rk3328 support internal phy inside, let's enable
it to work. And the internal phy need to do some special setting, so
register the rockchip internal phy driver.

David Wu (12):
  net: phy: Add rockchip phy driver support
  multi_v7_defconfig: Make rockchip phy built-in
  arm64: defconfig: Enable CONFIG_ROCKCHIP_PHY
  net: stmmac: dwmac-rk: Remove unwanted code for rk3328_set_to_rmii()
  Documentation: net: phy: Add phy-is-internal binding
  net: stmmac: dwmac-rk: Add internal phy support
  net: stmmac: dwmac-rk: Add internal phy support for rk3228
  net: stmmac: dwmac-rk: Add internal phy supprot for rk3328
  ARM: dts: rk322x: Add support internal phy for gmac
  ARM: dts: rk3228-evb: Enable the internal phy for gmac
  ARM64: dts: rockchip: Add gmac2phy node support for rk3328
  ARM64: dts: rockchip: Enable gmac2phy for rk3328-evb

 Documentation/devicetree/bindings/net/phy.txt      |   3 +
 .../devicetree/bindings/net/rockchip-dwmac.txt     |   4 +-
 arch/arm/boot/dts/rk3228-evb.dts                   |  32 +++
 arch/arm/boot/dts/rk322x.dtsi                      |   8 +-
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  17 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  37 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 129 +++++++++++-
 drivers/net/phy/Kconfig                            |   5 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/rockchip.c                         | 233 +++++++++++++++++++++
 12 files changed, 460 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/phy/rockchip.c

-- 
1.9.1
