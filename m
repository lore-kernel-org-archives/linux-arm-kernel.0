From: david.wu@rock-chips.com (David Wu)
Date: Thu, 10 Aug 2017 21:56:39 +0800
Subject: [PATCH v5 00/11] Add the integrated PHY support
Message-ID: <1502373410-2423-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228 and rk3328 support integrated PHY inside, let's enable
it to work. And the integrated PHY need to do some special setting,
so register the rockchip integrated PHY driver.

David Wu (11):
  net: phy: Add rockchip PHY driver support
  multi_v7_defconfig: Make rockchip PHY built-in
  arm64: defconfig: Enable CONFIG_ROCKCHIP_PHY
  net: stmmac: dwmac-rk: Remove unwanted code for rk3328_set_to_rmii()
  Documentation: net: phy: Add phy-is-integrated binding
  net: stmmac: dwmac-rk: Add integrated PHY support
  net: stmmac: dwmac-rk: Add integrated PHY support for rk3228
  net: stmmac: dwmac-rk: Add integrated PHY supprot for rk3328
  ARM: dts: rk3228-evb: Enable the integrated PHY for gmac
  ARM64: dts: rockchip: Add gmac2phy node support for rk3328
  ARM64: dts: rockchip: Enable gmac2phy for rk3328-evb

 Documentation/devicetree/bindings/net/phy.txt  |   5 +
 arch/arm/boot/dts/rk3228-evb.dts               |  34 ++++
 arch/arm/configs/multi_v7_defconfig            |   1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts    |  17 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi       |  39 +++++
 arch/arm64/configs/defconfig                   |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 140 +++++++++++++--
 drivers/net/phy/Kconfig                        |   5 +
 drivers/net/phy/Makefile                       |   1 +
 drivers/net/phy/rockchip.c                     | 233 +++++++++++++++++++++++++
 10 files changed, 466 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/phy/rockchip.c

-- 
1.9.1
