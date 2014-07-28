From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Jul 2014 13:49:13 +0200
Subject: [GIT PULL 2/2] ARM: dts: changes for existing boards
In-Reply-To: <2320363.GkHcuEZQtr@diego>
References: <2320363.GkHcuEZQtr@diego>
Message-ID: <2176060.hk5pTSTILF@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1fe69496cf463b654d2d6e1a9a10fb8d99f10831:

  ARM: rockchip: Select ARCH_HAS_RESET_CONTROLLER (2014-07-13 12:17:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.17-rockchip-rk3xxx-dts

for you to fetch changes up to 08567053f5cc4255ab53b75277b6102a3202bd75:

  ARM: dts: rk3188-radxarock: add GPIO IR receiver node (2014-07-27 00:25:59 +0200)

----------------------------------------------------------------
Collected changes for existing Rockchip boards
- convert to new clock driver
- bring structure in line with recent rk3288 comments
  (no soc-nodes, using phandles when adding changes, sorted by address)
- i2c, board-pmic and pwm nodes nodes
- sd card slot and ir receiver on radxa rock

----------------------------------------------------------------
Beniamino Galvani (3):
      ARM: dts: add i2c and regulator nodes to rk3188-radxarock
      ARM: dts: rockchip: add pwm nodes
      ARM: dts: rk3188-radxarock: add GPIO IR receiver node

Heiko Stuebner (12):
      ARM: dts: rockchip: add cru nodes and update device clocks to use it
      ARM: dts: rockchip: move oscillator input clock into main dtsi
      arm: dts: rockchip: remove obsolete clock gate definitions
      ARM: dts: rockchip: remove soc subnodes
      ARM: dts: rockchip: add handles for shared nodes that don't have one yet
      ARM: dts: uses handles to reference nodes for changes
      ARM: dts: rockchip: remove address from pinctrl nodes
      ARM: dts: rockchip: oder nodes by register address
      ARM: dts: add rk3066 and rk3188 i2c device nodes and pinctrl settings
      ARM: dts: rockchip: add tps65910 regulator for bqcurie2
      ARM: dts: rk3188-radxarock: enable sd-card slot
      ARM: dts: rockchip: add both clocks to uart nodes

 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 210 +++++++++-----
 arch/arm/boot/dts/rk3066a-clocks.dtsi  | 299 -------------------
 arch/arm/boot/dts/rk3066a.dtsi         | 515 +++++++++++++++++++++------------
 arch/arm/boot/dts/rk3188-clocks.dtsi   | 289 ------------------
 arch/arm/boot/dts/rk3188-radxarock.dts | 216 +++++++++++---
 arch/arm/boot/dts/rk3188.dtsi          | 442 ++++++++++++++++++----------
 arch/arm/boot/dts/rk3xxx.dtsi          | 348 ++++++++++++++--------
 7 files changed, 1176 insertions(+), 1143 deletions(-)
 delete mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 delete mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
