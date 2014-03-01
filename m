From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 01 Mar 2014 20:27:19 +0100
Subject: [GIT PULL] Rockchip SMP support for 3.15
Message-ID: <2945154.fxjrIo87Hl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.15-rockchip-smp

for you to fetch changes up to a7a2b3118b410fb3cd3a8363b157c56f4211ee05:

  ARM: rockchip: add smp bringup code (2014-03-01 17:21:57 +0100)

----------------------------------------------------------------
SMP-support for RK3066 and RK3188 SoCs from Rockchip.

----------------------------------------------------------------

The sram specific changes for reserved regions got already picked up
by Greg KH separately and do not cause compilation issues if missing.

Heiko Stuebner (4):
      ARM: rockchip: add snoop-control-unit
      ARM: rockchip: add sram dt nodes and documentation
      ARM: rockchip: add power-management-unit
      ARM: rockchip: add smp bringup code

 .../devicetree/bindings/arm/rockchip/pmu.txt       |  16 ++
 .../devicetree/bindings/arm/rockchip/smp-sram.txt  |  30 ++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  13 ++
 arch/arm/boot/dts/rk3188.dtsi                      |  13 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  10 ++
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 arch/arm/mach-rockchip/Makefile                    |   1 +
 arch/arm/mach-rockchip/core.h                      |  22 +++
 arch/arm/mach-rockchip/headsmp.S                   |  30 ++++
 arch/arm/mach-rockchip/platsmp.c                   | 184 +++++++++++++++++++++
 arch/arm/mach-rockchip/rockchip.c                  |   2 +
 11 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
 create mode 100644 arch/arm/mach-rockchip/core.h
 create mode 100644 arch/arm/mach-rockchip/headsmp.S
 create mode 100644 arch/arm/mach-rockchip/platsmp.c
