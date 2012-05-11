From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 11 May 2012 21:01:59 +0200
Subject: [GIT PULL] Renesas ARM-based platforms updates for v3.5
Message-ID: <201205112101.59949.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit 5658c94096c16e769203b6dea5e5f04e7ff12633

    Merge branch 'renesas-kzm9g' into renesas-soc-new

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc-new

to receive new Renesas ARM-based platforms material for v3.5.  Included are:

 * Urgent regression and SMP fixes (also included in the fixes branch that I've
   just sent a separate pull request for in the hope it is still possible to
   push them for v3.4).  Two of those fixes are duplicated in the renesas-sh7372
   branch, which is because I learned that they were fixes for recent
   regressions after they had gone to that branch.  Sorry about that.

 * Updates for boards based on the sh7372 and r8a7740 SoCs.

 * Support for 2 new boards, armadillo800eva and KZM-A9-GT.

Thanks!


 arch/arm/boot/dts/sh7372.dtsi                  |   21 +
 arch/arm/configs/armadillo800eva_defconfig     |  142 +++++
 arch/arm/configs/kzm9g_defconfig               |  139 +++++
 arch/arm/mach-shmobile/Kconfig                 |   16 +-
 arch/arm/mach-shmobile/Makefile                |    2 +
 arch/arm/mach-shmobile/board-ag5evm.c          |   22 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |    2 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |  778 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-bonito.c          |    2 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |  454 ++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c        |   38 +-
 arch/arm/mach-shmobile/clock-r8a7740.c         |  128 ++++-
 arch/arm/mach-shmobile/headsmp.S               |   56 ++-
 arch/arm/mach-shmobile/include/mach/common.h   |    4 +-
 arch/arm/mach-shmobile/include/mach/intc.h     |   44 ++
 arch/arm/mach-shmobile/include/mach/irqs.h     |    2 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h   |    2 +
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    3 +
 arch/arm/mach-shmobile/intc-sh7372.c           |   34 +-
 arch/arm/mach-shmobile/pfc-r8a7740.c           |   39 ++
 arch/arm/mach-shmobile/pfc-sh73a0.c            |    4 +-
 arch/arm/mach-shmobile/platsmp.c               |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c         |   19 +-
 arch/arm/mach-shmobile/setup-r8a7779.c         |    4 +
 arch/arm/mach-shmobile/setup-sh7372.c          |   58 ++
 arch/arm/mach-shmobile/setup-sh73a0.c          |    4 +
 arch/arm/mach-shmobile/smp-r8a7779.c           |    8 +-
 arch/arm/mach-shmobile/smp-sh73a0.c            |    7 +-
 arch/arm/mach-shmobile/timer.c                 |   27 +-
 29 files changed, 1978 insertions(+), 83 deletions(-)

---------------

Bastian Hecht (1):
      ARM: sh-mobile: mackerel: Add error IRQ resource

Guennadi Liakhovetski (3):
      ARM: mach-shmobile: sh7372 CEU supports up to 8188x8188 images
      ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
      ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper

Kuninori Morimoto (38):
      ARM: mach-shmobile: sh7372: Add FSI DMAEngine support
      ARM: mach-shmobile: mackerel: Add FSI DMAEngine support
      ARM: mach-shmobile: bonito: make sure static function
      ARM: mach-shmobile: r8a7740: add gpio_irq support
      ARM: mach-shmobile: add armadillo800eva board support.
      ARM: mach-shmobile: armadillo800eva: add defconfig
      ARM: mach-shmobile: armadillo800eva: add support LCDC0
      ARM: mach-shmobile: armadillo800eva: add support gpio_key
      ARM: mach-shmobile: armadillo800eva: add support sh_eth
      ARM: mach-shmobile: armadillo800eva: add support ST1232
      ARM: mach-shmobile: r8a7740: cleanup I2C workaround method
      ARM: mach-shmobile: clock-r8a7740: add FSI clock
      ARM: mach-shmobile: clock-r8a7740: add USB clock
      ARM: mach-shmobile: clock-r8a7740: add SDHI clock
      ARM: mach-shmobile: clock-r8a7740: add MMCIF clock
      ARM: mach-shmobile: armadillo800eva: add USB function support
      ARM: mach-shmobile: armadillo800eva: add SDHI0 support
      ARM: mach-shmobile: armadillo800eva: add SDHI1 support
      ARM: mach-shmobile: armadillo800eva: add MMCIF support
      ARM: mach-shmobile: r8a7740: reserve DMA memory for the frame buffer
      ARM: mach-shmobile: add KZM-A9-GT board support
      ARM: mach-shmobile: kzm9g: add defconfig
      ARM: mach-shmobile: kzm9g: add SMSC 9221 support
      ARM: mach-shmobile: kzm9g: add external USB Host support
      ARM: mach-shmobile: kzm9g: add LCDC support
      ARM: mach-shmobile: kzm9g: add ST1232 Touchscreen support
      ARM: mach-shmobile: pfc-sh73a0: fixup MSEL2CR MSEL18 for I2C-3
      ARM: mach-shmobile: sh73a0.h: add GPIO_NR
      ARM: mach-shmobile: kzm9g: correct screen direction
      ARM: mach-shmobile: kzm9g: add MMCIF support
      ARM: mach-shmobile: kzm9g: add SDHI support
      ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
      ARM: mach-shmobile: clock-r8a7740: add sh-eth clock
      ARM: mach-shmobile: clock-r8a7740: use followparent_recalc on usb24s
      ARM: mach-shmobile: kzm9g: defconfig update
      ARM: mach-shmobile: armadillo800eva: defconfig update
      ARM / mach-shmobile: sh73a0 SMP TWD boot regression fix
      ARM: mach-shmobile: kzm9g: enable SMP boot

Magnus Damm (9):
      ARM: mach-shmobile: Introduce shmobile_setup_delay()
      ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
      ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
      ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
      ARM: mach-shmobile: Rework sh7372 INTCS demuxer V2
      ARM: mach-shmobile: sh7372 generic board support via DT V2
      ARM / mach-shmobile: Use preset_lpj with calibrate_delay()
      ARM / mach-shmobile: r8a7779 SMP TWD boot regression fix
      ARM / mach-shmobile: Invalidate caches when booting secondary cores
