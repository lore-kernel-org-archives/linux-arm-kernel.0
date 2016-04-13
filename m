From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 13 Apr 2016 11:22:54 +0200
Subject: [GIT PULL 3/4] Rockchip dts32 updates for v4.7 - part1
In-Reply-To: <2557248.QNyQ7BnmgO@diego>
References: <2557248.QNyQ7BnmgO@diego>
Message-ID: <3837294.STogGfLSTd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.7-rockchip-dts32-1

for you to fetch changes up to fbf15046f12d6c8d5821c0dc5bf3ffc55a132243:

  ARM: dts: rockchip: move rk3036 memory definition to board files (2016-04-06 16:30:33 -0700)

----------------------------------------------------------------
A lot display-controller nodes for DSI and the Analogix DP on rk3288
as well as general display+hdmi support on rk3036. With the Analogix
DP support, Veyron Chromeboks can now finally use their internal
display.

Other than this big improvement we have thermal support on the rk3228,
a long time missing binding document for the General Register Files
block, better operating points for Veyron devices and a bunch of fixes
with parts stemming from warnings that new dtc version can generate.

----------------------------------------------------------------
Caesar Wang (6):
      ARM: dts: rockchip: add vop device node for rk3036
      ARM: dts: rockchip: add hdmi device node for rk3036
      ARM: dts: rockchip: enable graphics support on rk3036-kylin
      ARM: dts: rockchip: add the thermal main info found on rk3228
      ARM: dts: rockchip: enable the tsadc for rk3228 evb
      ARM: dts: rockchip: add rk3288-veyron-jaq backlight and panel overrides

Heiko Stuebner (16):
      ARM: dts: rockchip: update rk3288-veyron cpu operating points
      ARM: dts: rockchip: fix rk3288 power-domain unit names
      ARM: dts: rockchip: fix missing usbphy unit-names
      ARM: dts: rockchip: clean up gpio-keys nodes
      ARM: dts: rockchip: drop unneeded properties from mipi node
      ARM: dts: rockchip: add missing unitname to cpu_leakage efuse
      ARM: dts: rockchip: add rk3288 edp-phy node
      ARM: dts: rockchip: add rk3288 displayport controller node
      ARM: dts: rockchip: move edp-hpd pin definition into common location
      ARM: dts: rockchip: add startup delay to rk3288-veyron panel-regulators
      ARM: dts: rockchip: add core rk3288-veyron backlight and panel nodes
      ARM: dts: rockchip: add rk3288-veyron-minnie backlight and panel settings
      ARM: dts: rockchip: override edp hpd handling on veyron-pinky and speedy
      ARM: dts: rockchip: simple panel and backlight supplies on veyron boards
      ARM: dts: rockchip: enable the eDP on rk3288 veyron devices
      ARM: dts: rockchip: move rk3036 memory definition to board files

Jianqun Xu (1):
      dt-bindings: add bindings for Rockchip grf

John Keeping (3):
      ARM: dts: rockchip: fix MIPI interrupt on rk3288
      ARM: dts: rockchip: fix audio interrupts on rk3288
      ARM: dts: rockchip: add mipi_dsi to VIO power domain on rk3288

Shawn Lin (1):
      ARM: dts: rockchip: remove broken-cd from emmc and sdio

 .../devicetree/bindings/soc/rockchip/grf.txt       |  35 ++++++++
 arch/arm/boot/dts/rk3036-evb.dts                   |   5 ++
 arch/arm/boot/dts/rk3036-kylin.dts                 |  18 +++-
 arch/arm/boot/dts/rk3036.dtsi                      |  71 +++++++++++++--
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |  11 ++-
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   9 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   6 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |   7 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   6 +-
 arch/arm/boot/dts/rk3228-evb.dts                   |   8 +-
 arch/arm/boot/dts/rk3228.dtsi                      |  69 ++++++++++++++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   8 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   9 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |   9 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |   7 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    | 100 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-jaq.dts            |  49 ++++++++--
 arch/arm/boot/dts/rk3288-veyron-jerry.dts          |   9 ++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts         |  44 +++++++++
 arch/arm/boot/dts/rk3288-veyron-pinky.dts          |   7 ++
 arch/arm/boot/dts/rk3288-veyron-speedy.dts         |  16 ++++
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  18 +++-
 arch/arm/boot/dts/rk3288.dtsi                      |  84 ++++++++++++++---
 23 files changed, 532 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
