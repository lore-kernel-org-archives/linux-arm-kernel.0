From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 16 Dec 2015 16:27:16 +0800
Subject: [PATCH 0/5] Kylin-board is based on RK3036 SOCs, add the initiation
Message-ID: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

version for working.

This series pacthes have the following decriptions:

PATCH[1/5]:
clk: rockchip: rk3036: include downstream muxes into fractional dividers

This patch is depend on Heiko's series pacthes.

a8a1de6 clk: rockchip: include downstream muxes into fractional dividers
(https://patchwork.kernel.org/patch/7053071/)
ab40856 clk: rockchip: handle mux dependency of fractional dividers
(https://patchwork.kernel.org/patch/7053051/)
c4c5582 clk: add flag for clocks that need to be enabled on rate changes
(https://patchwork.kernel.org/patch/7053041/)
---

PATCH[2/5]:
0a68e13 clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag for aclk_vio
The aclk_vio is marked as the ignore_unused since it's the noc clock.
let will fix the display issue.
---

PATCH[3/5]:
183a5eb ARM: dts: rockchip: update the core dts for rk3036
Update the rk3036 core dtsi, add the hdmi, lcdc, sdmmc, sdio .... node info
for rk3036, in general the function is verified by the UARL[0].

UARL[0]:https://github.com/rockchip-linux/kernel/ -b develop-v4.1
---

PATCH[4/5]:
962e1ad ARM: dts: rockchip: add the kylin board for rk3036
Add the rk3036-kylin dts for Kylin-board.
---

PATCH[5/5]:
d96f13a ARM: config: Add the rk3036 configure for kylin board
Add the defconfig for Kylin-board to better to know about that.

Note: I don't plan to upstream for this patch. :)
---

The game is just beginning ....



Caesar Wang (4):
  clk: rockchip: rk3036: include downstream muxes into fractional
    dividers
  ARM: dts: rockchip: update the core dts for rk3036
  ARM: dts: rockchip: add the kylin board for rk3036
  ARM: config: Add the rk3036 configure for kylin board

Yakir Yang (1):
  clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag for aclk_vio

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3036-kylin.dts                 | 302 +++++++++++++++++++++
 arch/arm/boot/dts/rk3036.dtsi                      | 225 ++++++++++++++-
 arch/arm/configs/rk3036_kylin_defconfig            | 230 ++++++++++++++++
 drivers/clk/rockchip/clk-rk3036.c                  |  37 +--
 6 files changed, 777 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3036-kylin.dts
 create mode 100644 arch/arm/configs/rk3036_kylin_defconfig

-- 
1.9.1
