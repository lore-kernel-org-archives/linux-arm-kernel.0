From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 08 Sep 2016 16:10:35 +0200
Subject: [GIT PULL 2/3] Rockchip dts32 changes for 4.9
In-Reply-To: <1770547.rOXegfrGOH@phil>
References: <1770547.rOXegfrGOH@phil>
Message-ID: <1481725.D51jRkC1a3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

below you can find a pull request for 32bit devicetree changes which
the tag will hopefully explain sufficiently.


Heiko

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.9-rockchip-dts32-1

for you to fetch changes up to 4314f4b6720d96b0504da30112b6d42d13c3e50f:

  ARM: dts: rockchip: Add sensor-supplies on PopMetal-RK3288 board (2016-09-05 11:09:41 +0200)

----------------------------------------------------------------
32bit Rockchip devicetree changes containing two new rk3288 boards (Fennec
and Firefly-reload), display support for the rk3288-evb, support for the
recently added firmware reboot-flag support and some housekeeping cleanups.

----------------------------------------------------------------
Andy Yan (5):
      soc: rockchip: add reboot-mode header
      ARM: dts: rockchip: add syscon-reboot-mode DT node
      ARM: dts: rockchip: enable usbotg for Popemtal-rk3288 board
      ARM: dts: rockchip: fix L3G4200D i2c address on PopMetal-RK3288 board
      ARM: dts: rockchip: Add sensor-supplies on PopMetal-RK3288 board

Heiko Stuebner (2):
      ARM: dts: rockchip: move rk3288 usbphy under the GRF node
      Merge branch 'v4.9-shared/soc-hdr' into v4.9-armsoc/dts32

Randy Li (3):
      ARM: dts: rockchip: add rk3288-firefly-reload
      ARM: dts: rockchip: remove excess sd properties from firefly reload
      ARM: dts: rockchip: add missing regulators for firefly reload board

Xing Zheng (1):
      ARM: dts: rockchip: add dts for RK3288-Fennec boards

Yakir Yang (3):
      ARM: dts: rockchip: add eDP/panel display device nodes for rk3288-evb
      ARM: dts: rockchip: add the panel power supply for rk3288-evb board with act8846 pmu
      ARM: dts: rockchip: add the panel power supply for rk3288-evb board with rk808 pmu

 Documentation/devicetree/bindings/arm/rockchip.txt |   8 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/rk3036.dtsi                      |  12 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |   4 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |   4 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  45 ++-
 arch/arm/boot/dts/rk3288-fennec.dts                | 382 +++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi  | 310 ++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-reload.dts        | 403 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288-popmetal.dts              |  12 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  73 ++--
 arch/arm/boot/dts/rk3xxx.dtsi                      |  12 +-
 include/dt-bindings/soc/rockchip,boot-mode.h       |  15 +
 13 files changed, 1245 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-fennec.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-reload.dts
 create mode 100644 include/dt-bindings/soc/rockchip,boot-mode.h
