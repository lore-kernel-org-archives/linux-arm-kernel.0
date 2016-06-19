From: olof@lixom.net (Olof Johansson)
Date: Sat, 18 Jun 2016 23:15:12 -0700
Subject: [GIT PULL] ARM: SoC fixes for 4.7-rc
Message-ID: <20160619061512.GA18174@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 8fd0976702f05042c776848819e5fd2a835f23c9:

  Merge tag 'gpmc-omap-fixes-for-v4.7' of https://github.com/rogerq/linux into fixes (2016-06-18 22:59:07 -0700)

----------------------------------------------------------------
ARM: SoC fixes

Another batch of fixes for ARM SoC platforms. Most are smaller fixes,

Two areas that are worth pointing out are:

* OMAP had a handful of changes to voltage specs that caused a bit of churn,
  most of volume of change in this branch is due to this.

* There are a couple of _rcuidle fixes from Paul that touch common code and
  came in through the OMAP tree since they were the ones who saw the problems.

The rest is smaller changes across a handful of platforms.

----------------------------------------------------------------
Arnd Bergmann (2):
      ARM: samsung: improve static dma_mask definition
      ARM: exynos: don't select keyboard driver

Chen-Yu Tsai (2):
      ARM: dts: sun6i: primo81: Drop constraints on dc1sw regulator
      ARM: dts: sun6i: yones-toptech-bs1078-v2: Drop constraints on dc1sw regulator

Dave Gerlach (3):
      ARM: OMAP2+: AM43XX: Enable fixes for Cortex-A9 errata
      ARM: OMAP2+: Select OMAP_INTERCONNECT for SOC_AM43XX
      ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed for tps65218

Enric Balletbo i Serra (2):
      ARM: dts: igep00x0: Add SD card-detect.
      ARM: dts: igep0020: Add SD card write-protect pin.

Fabio Estevam (2):
      ARM: imx6ul: Fix Micrel PHY mask
      MAINTAINERS: Add myself as reviewer of ARM FSL/NXP

Franklin S Cooper Jr (1):
      ARM: dts: dra7: Add gpmc dma channel

Janusz Krzysztofik (1):
      ARM: OMAP1: fix ams-delta FIQ handler to work with sparse IRQ

Javier Martinez Canillas (2):
      ARM: dts: exynos: Fix port nodes names for Exynos5250 Snow board
      ARM: dts: exynos: Fix port nodes names for Exynos5420 Peach Pit board

Lee Jones (1):
      ARM: dts: STi: stih407-family: Disable reserved-memory co-processor nodes

Marek Vasut (1):
      ARM: dts: socfpga: Add missing PHY phandle

Masahiro Yamada (1):
      arm64: dts: drop "arm,amba-bus" in favor of "simple-bus" part 2

Nicolas Chauvet (2):
      ARM: dts: Add non-removable to hsmmc on hp-t410
      ARM: dts: disable mmc by default and enable when needed for dm814x

Nishanth Menon (7):
      ARM: dts: omap5-board-common: Describe the voltage supply mapping accurately
      ARM: OMAP5 / DRA7: Introduce workaround for 801819
      ARM: dts: am57xx-idk-common: Fix input supply names
      ARM: OMAP2: Enable Errata 430973 for OMAP3
      ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per to ON
      ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
      ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret

Ocquidant, Sebastien (1):
      memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing

Olliver Schinagl (1):
      ARM: dts: sunxi: Add OLinuXino Lime2 eMMC to the Makefile

Olof Johansson (9):
      Merge tag 'samsung-fixes-4.7' of git://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'omap-for-v4.7/fixes-v2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'omap-for-v4.7-dts-fixes1' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'socfpga_fix_for_v4.7' of git://git.kernel.org/.../dinguyen/linux into fixes
      Merge tag 'samsung-fixes-4.7-2' of git://git.kernel.org/.../krzk/linux into fixes
      Merge tag 'imx-fixes-4.7' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'fixes-rcu-fiq-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'omap-for-v4.7/fixes-powedomain' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'gpmc-omap-fixes-for-v4.7' of https://github.com/rogerq/linux into fixes

Paul E. McKenney (2):
      arm: Use _rcuidle tracepoint to allow use from idle
      arm: Use _rcuidle for smp_cross_call() tracepoints

Tero Kristo (1):
      ARM: OMAP2+: timer: add probe for clocksources

Tomi Valkeinen (1):
      ARM: dts: DRA74x: fix DSS PLL2 addresses

Tony Lindgren (3):
      ARM: dts: Fix igepv5 audiopwon-gpio
      ARM: dts: Fix uart wakeirq on omap5 by removing WAKEUP_EN for omaps
      ARM: dts: Fix ldo7 source for HDMI on igepv5

 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |  2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           | 32 ++++-----
 arch/arm/boot/dts/dm8148-evm.dts                   |  8 +++
 arch/arm/boot/dts/dm8148-t410.dts                  |  9 +++
 arch/arm/boot/dts/dra7.dtsi                        |  2 +
 arch/arm/boot/dts/dra74x.dtsi                      |  4 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 13 +++-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 13 +++-
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  2 +-
 arch/arm/boot/dts/omap3-igep.dtsi                  |  1 +
 arch/arm/boot/dts/omap3-igep0020-common.dtsi       | 11 ++++
 arch/arm/boot/dts/omap3-n900.dts                   |  4 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  6 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |  6 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          | 48 +++++++++++++-
 arch/arm/boot/dts/omap5-igep0050.dts               | 26 ++++++++
 arch/arm/boot/dts/omap5-uevm.dts                   | 10 +++
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |  1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  3 +
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  2 -
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |  2 -
 arch/arm/configs/exynos_defconfig                  |  1 +
 arch/arm/configs/multi_v7_defconfig                |  1 +
 arch/arm/kernel/smp.c                              |  2 +-
 arch/arm/mach-exynos/Kconfig                       |  1 -
 arch/arm/mach-imx/mach-imx6ul.c                    |  2 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |  6 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |  5 +-
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h   |  2 +
 arch/arm/mach-omap2/Kconfig                        | 12 ++++
 arch/arm/mach-omap2/omap-secure.h                  |  1 +
 arch/arm/mach-omap2/omap-smp.c                     | 48 ++++++++++++--
 arch/arm/mach-omap2/powerdomain.c                  |  9 +--
 arch/arm/mach-omap2/powerdomains7xx_data.c         | 76 +---------------------
 arch/arm/mach-omap2/timer.c                        |  7 +-
 arch/arm/plat-samsung/devs.c                       |  2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                 |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  2 +-
 drivers/memory/omap-gpmc.c                         |  2 +-
 41 files changed, 252 insertions(+), 136 deletions(-)
