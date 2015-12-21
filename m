From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Dec 2015 02:24:13 +0100
Subject: [GIT PULL 2/3] rockchip dts32 changes for 4.5, round 2
In-Reply-To: <2532363.CsR3D6sdor@diego>
References: <2532363.CsR3D6sdor@diego>
Message-ID: <2674601.aqagTnGkXk@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

here is another pile of dts32 changes. Rockchip choose to support another
of their Cortex-A7 socs in mainline, so we have a new dtsi for the rk3228
and some other misc improvements described in the tag.



The following changes since commit 066111411101f6b020af1a7c752859a12476ba21:

  ARM: dts: rockchip: add gpio-ir-receiver to the R89 board (2015-12-04 20:01:27 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.5-rockchip-dts32-2

for you to fetch changes up to 94cf32b97bbb043b99e914aacff1a6d7833daf58:

  ARM: dts: rockchip: add the kylin board for rk3036 (2015-12-19 18:11:48 +0100)

----------------------------------------------------------------
Another new soc - the rk3228 quad-core cortex-a7, a new rk3036 board,
support for the efuses on Rockchip socs and some improvements for
rk3288 regulators.

----------------------------------------------------------------
Caesar Wang (5):
      ARM: dts: rockchip: fix voltage ranges for rk3288-evb-act8846 board
      ARM: dts: rockchip: add eFuse node for rk3066a SoCs
      ARM: dts: rockchip: add eFuse node for rk3188 SoCs
      ARM: dts: rockchip: add the sdio/sdmmc node for rk3036
      ARM: dts: rockchip: add the kylin board for rk3036

Chris Zhong (4):
      clk: rockchip: add id for mipidsi sclk on rk3288
      ARM: dts: rockchip: correct the name of REG8 for rk3288-evb-act8846
      ARM: dts: rockchip: add 2 regulators for rk3288-evb-act8846
      ARM: dts: rockchip: move the public part to rk3288-evb common

Heiko Stuebner (1):
      Merge branch 'v4.5-clk/clkids' into v4.5-armsoc/dts32

Jeffy Chen (3):
      clk: rockchip: add dt-binding header for rk3228
      ARM: dts: rockchip: add core rk3228 dtsi
      ARM: dts: rockchip: add rk3228-evb board

Matthias Brugger (1):
      ARM: dts: rockchip: Fix typo in rk3288 sdmmc card detect pin name

Xing Zheng (1):
      ARM: dts: rockchip: fix the pinctrl bias settings for rk3036

ZhengShunQian (2):
      clk: rockchip: Add the clock ids of rk3288 eFuses
      ARM: dts: rockchip: add eFuse config of rk3288 SoC

 Documentation/devicetree/bindings/arm/rockchip.txt |   8 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/rk3036-kylin.dts                 | 300 ++++++++++++++
 arch/arm/boot/dts/rk3036.dtsi                      | 106 ++++-
 arch/arm/boot/dts/rk3066a.dtsi                     |  13 +
 arch/arm/boot/dts/rk3188.dtsi                      |  13 +
 arch/arm/boot/dts/rk3228-evb.dts                   |  66 +++
 arch/arm/boot/dts/rk3228.dtsi                      | 442 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |  44 +-
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |  27 --
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  37 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  15 +-
 include/dt-bindings/clock/rk3228-cru.h             | 220 ++++++++++
 include/dt-bindings/clock/rk3288-cru.h             |   3 +
 14 files changed, 1237 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3036-kylin.dts
 create mode 100644 arch/arm/boot/dts/rk3228-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3228.dtsi
 create mode 100644 include/dt-bindings/clock/rk3228-cru.h
