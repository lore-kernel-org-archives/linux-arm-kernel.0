From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 09 Jun 2017 12:13:44 +0200
Subject: [GIT PULL 1/3] Rockchip dts32 updates for 4.13 part1
Message-ID: <2090243.QTRV0U63fj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below and in the subsequent replies Rockchip-related changes
for 4.13. The tags describe the individual changes, but hightlight are probably
the Mali-Midgard nodes on rk3288 and rk3399-Firefly board.

So if nothing looks out of place, please pull.

Thanks
Heiko

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.13-rockchip-dts32-1

for you to fetch changes up to 81b61d37705173b8b9eb52c4566a8fc7c7099520:

  ARM: dts: rockchip: enable usb for rk3229 evb board (2017-06-02 14:11:57 +0200)

----------------------------------------------------------------
A bunch of changes including mali gpu nodes for rk3288 boards
following (and including) the new Mali Midgard binding; a lot of
improvements for the rk3228/rk3229 socs (tsadc, operating points,
usb, clock-rates, pinctrl, watchdog); finalizing the rk1108->rv1108
rename and adc buttons for the rk3288 firefly boards.

----------------------------------------------------------------
Andy Yan (2):
      ARM: dts: rockchip: rename core dtsi from RK1108 to RV1108
      ARM: dts: rockchip: rename RK1108-evb to RV1108-evb

Eddie Cai (1):
      clk: rockchip: add ids for camera on rk3399

Elaine Zhang (2):
      clk: rockchip: add clock-ids for more rk3228 clocks
      ARM: dts: rockchip: set default rates for core clocks on rk322x

Enric Balletbo i Serra (1):
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-veyron

Finley Xiao (1):
      ARM: dts: rockchip: add operating-points-v2 for cpu on rk322x

Frank Wang (3):
      ARM: dts: rockchip: add watchdog device node on rk322x
      ARM: dts: rockchip: correct rk322x uart2 pinctrl
      ARM: dts: rockchip: add second uart2 pinctrl on rk322x

Guillaume Tucker (4):
      dt-bindings: gpu: add bindings for the ARM Mali Midgard GPU
      ARM: dts: rockchip: add ARM Mali GPU node for rk3288
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-rock2-som
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-firefly

Heiko Stuebner (1):
      Merge branch 'v4.13-shared/clkids' into v4.13-armsoc/dts32

Randy Li (1):
      ARM: dts: rockchip: add adc button for Firefly

Rocky Hao (1):
      ARM: dts: rockchip: set a sane frequence for tsadc on rk322x

Sjoerd Simons (1):
      ARM: dts: rockchip: Setup usb vbus-supply on rk3288-rock2

Sugar Zhang (1):
      ARM: dts: rockchip: fix rk322x i2s1 pinctrl error

William Wu (2):
      ARM: dts: rockchip: add usb nodes on rk322x
      ARM: dts: rockchip: enable usb for rk3229 evb board

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   |  86 +++++++++
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/rk3229-evb.dts                   |  74 ++++++++
 arch/arm/boot/dts/rk322x.dtsi                      | 211 +++++++++++++++++++--
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |  17 ++
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  18 ++
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   5 +
 arch/arm/boot/dts/rk3288-rock2-square.dts          |   8 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   5 +
 arch/arm/boot/dts/rk3288.dtsi                      |  43 +++++
 .../boot/dts/{rk1108-evb.dts => rv1108-evb.dts}    |   6 +-
 arch/arm/boot/dts/{rk1108.dtsi => rv1108.dtsi}     |  20 +-
 include/dt-bindings/clock/rk3228-cru.h             |  47 +++++
 include/dt-bindings/clock/rk3399-cru.h             |   2 +
 15 files changed, 517 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
 rename arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} (94%)
 rename arch/arm/boot/dts/{rk1108.dtsi => rv1108.dtsi} (95%)
