From: david.wu@rock-chips.com (David Wu)
Date: Fri, 23 Jun 2017 12:41:58 +0800
Subject: [PATCH 00/11] Add the mac internal ephy support
Message-ID: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228 and rk3328 support internal mac phy inside, let's enable
it to work. And the internal phy need to do some special setting, so
register the rockchip mac internal phy driver, not use the genphy driver. 

David Wu (11):
  net: phy: Add rockchip phy driver support
  multi_v7_defconfig: Make rockchip mac phy built-in
  arm64: defconfig: Enable CONFIG_ROCKCHIP_MAC_PHY
  net: stmmac: dwmac-rk: Remove unwanted code for rk3328_set_to_rmii()
  net: stmmac: dwmac-rk: Add internal phy support
  net: stmmac: dwmac-rk: Add internal phy support for rk3228
  net: stmmac: dwmac-rk: Add internal phy supprot for rk3328
  ARM: dts: rk322x: Add support internal phy for gmac
  ARM: dts: rk3228-evb: Enable the internal phy for gmac
  ARM64: dts: rockchip: Add gmac2phy node support for rk3328
  ARM64: dts: rockchip: Enable gmac2phy for rk3328-evb

 .../devicetree/bindings/net/rockchip-dwmac.txt     |   3 +
 arch/arm/boot/dts/rk3228-evb.dts                   |  20 ++++
 arch/arm/boot/dts/rk322x.dtsi                      |   8 +-
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  17 +++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  25 +++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 123 ++++++++++++++++++++-
 drivers/net/phy/Kconfig                            |   4 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/rockchip.c                         |  94 ++++++++++++++++
 11 files changed, 287 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/phy/rockchip.c

-- 
1.9.1
