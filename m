From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:05 -0700
Subject: [GIT PULL 2/7] ARM: SoC cleanups for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A large cleanup branch this release, with a healthy 10k negative line delta.

Most of this is removal of legacy (non-DT) support of shmobile
platforms. There is also removal of two non-DT platforms on OMAP,
and the plat-samsung directory is cleaned out by moving most of the
previously shared-location-but-not-actually-shared files from there to
the appropriate mach directories instead.

There are other sets of changes in here as well:

- Rob Herring removed use of set_irq_flags under all platforms and
moved to genirq alternatives
- A series of timer API conversions to set-state interface
- ep93xx, nomadik and ux500 cleanups from Linus Walleij
- __init annotation fixes from Nicolas Pitre
+ a bunch of other changes that all add up to a nice set of cleanups

----------------------------------------------------------------

The following changes since commit 8f844fac5c5b97534cff57310b1d660e8210ee00:

  Merge branch 'next/fixes-non-critical' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to 97a2482d9891f0ad6a3710e0b6ae9949c140c7f1:

  Merge tag 'tegra-for-4.3-cleanup' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/cleanup

----------------------------------------------------------------

Florian Fainelli (1):
      ARM: BCM63xx: Remove custom secondary_startup function

Geert Uytterhoeven (24):
      ARM: shmobile: R-Mobile: Move to_rmobile_pd from header to source file
      ARM: shmobile: R-Mobile: Use BIT() macro instead of open coding
      ARM: shmobile: r8a7779: Remove GENPD_FLAG_PM_CLK flag
      ARM: shmobile: Remove legacy board code for KZM-A9-GT
      ARM: shmobile: Remove legacy kzm9g_defconfig
      ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
      ARM: shmobile: Remove legacy SoC code for SH-Mobile AG5
      ARM: shmobile: Remove legacy board code for Armadillo-800 EVA
      ARM: shmobile: Remove legacy armadillo800eva_defconfig
      ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for legacy builds
      ARM: shmobile: Remove legacy SoC code for R-Mobile A1
      ARM: shmobile: Remove unused dma-register.h
      ARM: shmobile: R-Mobile: Remove legacy PM Domain code
      ARM: shmobile: Remove obsolete zboot support
      ARM: shmobile: R-Car Gen2: CONFIG_ARCH_SHMOBILE_MULTI is always set
      ARM: shmobile: timer: r8a73a4 and r8a7790 are multi-platform only
      ARM: shmobile: R-Car: Improve documentation
      ARM: shmobile: R-Car: Shrink rcar_sysc_ch size
      ARM: shmobile: R-Car: Break infinite loop
      ARM: shmobile: R-Car: Make struct rcar_sysc_ch * parameters const
      ARM: shmobile: R-Car: Use BIT() macro instead of open coding
      ARM: shmobile: R-Car: Get rid of on_off_fn() function pointer
      ARM: shmobile: r8a7779: Make struct rcar_sysc_ch const
      ARM: shmobile: r8a7790: Make struct rcar_sysc_ch const

H Hartley Sweeten (3):
      ARM: ep93xx: remove memory configuration options
      ARM: ep93xx: vision_ep9307: enable DMA for SPI
      ARM: ep93xx: vision_ep9307: add audio support

Hans Ulli Kroll (3):
      ARM: gemini: Add missing register definitions for gemini timer
      ARM: gemini: Use timer1 for clockevent
      ARM: gemini: Setup timer3 as free running timer

Jiang Liu (2):
      ARM/irq: Use access helper irq_data_get_affinity_mask()
      ARM, irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc

Joe Perches (1):
      ARM: orion5x: Use vsprintf %pM extension

Krzysztof Kozlowski (3):
      ARM: EXYNOS: Make local function static
      ARM: EXYNOS: Remove duplicated define of SLEEP_MAGIC
      ARM: EXYNOS: Drop owner assignment in pmu.c

Kukjin Kim (14):
      ARM: SAMSUNG: make local setup-camif in mach-s3c24xx
      ARM: SAMSUNG: make local dev-backlight in mach-s3c64xx
      ARM: SAMSUNG: make local s5p-dev-mfc in mach-exynos
      ARM: SAMSUNG: local regs-srom header in mach-exynos
      ARM: SAMSUNG: local fb-core header in mach-s3c24xx
      ARM: SAMSUNG: local nand-core header in mach-s3c24xx
      ARM: SAMSUNG: local spi-core header in mach-s3c24xx
      ARM: SAMSUNG: local regs-usb-hsotg-phy header in mach-s3c64xx
      ARM: SAMSUNG: local ata-core header in mach-s3c64xx
      ARM: SAMSUNG: local backlight header in mach-s3c64xx
      ARM: SAMSUNG: local irq-uart header in mach-s3c64xx
      ARM: SAMSUNG: local onenand-core header in mach-s3c64xx
      ARM: SAMSUNG: local watchdog-reset header in mach-s3c64xx
      ARM: SAMSUNG: remove keypad-core header in plat-samsung

Linus Walleij (13):
      ARM: ep93xx: move timer to its own file
      ARM: ep93xx: switch to GENERIC_CLOCKEVENTS
      ARM: ep93xx: use non-raw accessors for timer
      ARM: ep93xx: switch clockevent to timer 3
      ARM: ep93xx: update comment on timer usage
      ARM: ep93xx: toss the device ID into the entropy pool
      ARM: ep93xx: simone: enable DMA on the SPI host
      ARM: ux500: simplify secondary CPU boot
      ARM: nomadik: move hog code to use DT hogs
      ARM: nomadik: selectively enable UART0 on boards
      ARM: nomadik: move l2x0 setup to device tree
      ARM: nomadik: push accelerometer down to boards
      ARM/fb: ep93xx: switch framebuffer to use modedb only

Magnus Damm (6):
      ARM: shmobile: r8a7779: Generic CCF and timer support
      ARM: shmobile: r8a7779: Generic SMP ops
      ARM: shmobile: marzen-reference: Remove C board code
      ARM: shmobile: r8a7779: Cleanup header file
      ARM: shmobile: marzen: Remove legacy board code
      ARM: shmobile: r8a7779: Remove legacy SoC code

Marcel Ziswiler (1):
      ALSA: hda/tegra - Fix hda2codec_2x clock and reset names

Nicolas Pitre (1):
      ARM: appropriate __init annotation for const data

Olof Johansson (14):
      Merge tag 'renesas-cleanup-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'renesas-pm-domain-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge branch 'ARM/clkevt/set-state-4.3' of git://git.kernel.org/.../vireshk/linux into next/cleanup
      Merge tag 'mvebu-cleanup-4.3-1' of git://git.infradead.org/linux-mvebu into next/cleanup
      Merge tag 'arm-soc/for-4.3/soc' of http://github.com/broadcom/stblinux into next/cleanup
      Merge tag 'ep93xx-cleanup' of git://git.kernel.org/.../linusw/linux-integrator into next/cleanup
      Merge tag 'omap-for-v4.3/legacy-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'renesas-cleanup2-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge branch 'queue/irq/arm' of git://git.kernel.org/.../tip/tip into next/cleanup
      Merge tag 'renesas-marzen-board-removal-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge branch 'fixes' into next/cleanup
      ARM: shmobile: Fix mismerges
      Merge tag 'samsung-cleanup' of git://git.kernel.org/.../kgene/linux-samsung into next/cleanup
      Merge tag 'tegra-for-4.3-cleanup' of git://git.kernel.org/.../tegra/linux into next/cleanup

Rob Herring (1):
      ARM: kill off set_irq_flags usage

Sudeep Holla (1):
      ARM: BCM63xx: fix parameter to of_get_cpu_node in bcm63138_smp_boot_secondary

Thierry Reding (1):
      ALSA: hda/tegra: Order clock and reset names consistently

Thomas Gleixner (9):
      ARM/orion: Consolidate chained IRQ handler install/remove
      ARM/locomo: Consolidate chained IRQ handler install/remove
      ARM/LPC32xx: Use irq_set_handler_locked()
      ARM/locomo: Prepare locomo_handler for irq argument removal
      ARM/sa1111: Prepare sa1111_irq_handler for irq argument removal
      ARM/dove: Prepare pmu_irq_handler for irq argument removal
      ARM/pxa: Prepare *_irq_handler for irq argument removal
      ARM/pxa: Prepare balloon3_irq_handler for irq argument removal
      ARM/orion/gpio: Prepare gpio_irq_handler for irq argument removal

Thomas Petazzoni (1):
      ARM: mvebu: add missing newline at end of messages

Tony Lindgren (2):
      ARM: OMAP2+: Remove legacy booting support for LogicPD Torpedo
      ARM: OMAP2+: Remove legacy booting support for Pandora

Viresh Kumar (19):
      ARM/smp_twd: Migrate to new 'set-state' interface
      ARM/cns3xxx/timer: Migrate to new 'set-state' interface
      ARM/davinci/time: Migrate to new 'set-state' interface
      ARM/dc21285-timer: Migrate to new 'set-state' interface
      ARM/gemini/time: Migrate to new 'set-state' interface
      ARM/imx/epit: Migrate to new 'set-state' interface
      ARM/ixp4xx/timer: Migrate to new 'set-state' interface
      ARM/ks8695/time: Migrate to new 'set-state' interface
      ARM/lpc32xx/timer: Migrate to new 'set-state' interface
      ARM/mmp/time: Migrate to new 'set-state' interface
      ARM/netx/time: Migrate to new 'set-state' interface
      ARM/omap1/time: Migrate to new 'set-state' interface
      ARM/omap1/timer32: Migrate to new 'set-state' interface
      ARM/omap2/timer: Migrate to new 'set-state' interface
      ARM/SPEAr/time: Migrate to new 'set-state' interface
      ARM/w90x900/time: Migrate to new 'set-state' interface
      ARM/iop/time: Migrate to new 'set-state' interface
      ARM/orion/time: Migrate to new 'set-state' interface
      ARM: ep93xx/timer: Migrate to new 'set-state' interface

Wolfram Sang (1):
      ARM: shmobile: apmu: silence build warnings


 .../bindings/sound/nvidia,tegra30-hda.txt       |    8 +-
 MAINTAINERS                                     |    2 -
 arch/arm/Kconfig                                |   11 +-
 arch/arm/boot/compressed/Makefile               |    4 -
 arch/arm/boot/compressed/head-shmobile.S        |   71 -
 arch/arm/boot/dts/Makefile                      |    5 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts         |   39 +-
 arch/arm/boot/dts/ste-nomadik-s8815.dts         |   44 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi      |   22 +-
 arch/arm/common/it8152.c                        |    2 +-
 arch/arm/common/locomo.c                        |   11 +-
 arch/arm/common/sa1111.c                        |    9 +-
 arch/arm/configs/armadillo800eva_defconfig      |  162 ---
 arch/arm/configs/kzm9g_defconfig                |  154 --
 arch/arm/kernel/irq.c                           |    4 +-
 arch/arm/kernel/psci.c                          |    2 +-
 arch/arm/kernel/smp_twd.c                       |   48 +-
 arch/arm/mach-at91/at91rm9200.c                 |    2 +-
 arch/arm/mach-at91/at91sam9.c                   |    6 +-
 arch/arm/mach-at91/pm.c                         |    2 +-
 arch/arm/mach-at91/sama5.c                      |    4 +-
 arch/arm/mach-bcm/Makefile                      |    4 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S             |   23 -
 arch/arm/mach-bcm/bcm63xx_smp.c                 |    4 +-
 arch/arm/mach-bcm/bcm63xx_smp.h                 |    1 -
 arch/arm/mach-bcm/bcm_5301x.c                   |    2 +-
 arch/arm/mach-bcm/bcm_kona_smc.c                |    2 +-
 arch/arm/mach-clps711x/board-autcpu12.c         |    2 +-
 arch/arm/mach-cns3xxx/core.c                    |   59 +-
 arch/arm/mach-davinci/cp_intc.c                 |    2 +-
 arch/arm/mach-davinci/da850.c                   |    4 +-
 arch/arm/mach-davinci/da8xx-dt.c                |    4 +-
 arch/arm/mach-davinci/time.c                    |   54 +-
 arch/arm/mach-digicolor/digicolor.c             |    2 +-
 arch/arm/mach-dove/irq.c                        |    5 +-
 arch/arm/mach-ebsa110/core.c                    |    2 +-
 arch/arm/mach-ep93xx/Kconfig                    |   54 -
 arch/arm/mach-ep93xx/Makefile                   |    2 +-
 arch/arm/mach-ep93xx/Makefile.boot              |   15 +-
 arch/arm/mach-ep93xx/core.c                     |  116 +-
 arch/arm/mach-ep93xx/edb93xx.c                  |    2 -
 arch/arm/mach-ep93xx/simone.c                   |    3 +-
 arch/arm/mach-ep93xx/snappercl15.c              |    2 -
 arch/arm/mach-ep93xx/timer-ep93xx.c             |  143 ++
 arch/arm/mach-ep93xx/vision_ep9307.c            |   63 +-
 arch/arm/mach-exynos/Kconfig                    |    5 +
 arch/arm/mach-exynos/Makefile                   |    2 +
 arch/arm/mach-exynos/common.h                   |    6 +
 arch/arm/mach-exynos/firmware.c                 |    2 -
 arch/arm/mach-exynos/pmu.c                      |    3 +-
 .../include/plat => mach-exynos}/regs-srom.h    |    3 +-
 .../{plat-samsung => mach-exynos}/s5p-dev-mfc.c |    0
 arch/arm/mach-exynos/suspend.c                  |    8 +-
 arch/arm/mach-footbridge/common.c               |    2 +-
 arch/arm/mach-footbridge/dc21285-timer.c        |   48 +-
 arch/arm/mach-footbridge/isa-irq.c              |    8 +-
 arch/arm/mach-gemini/gpio.c                     |    2 +-
 arch/arm/mach-gemini/include/mach/hardware.h    |    3 -
 arch/arm/mach-gemini/irq.c                      |    2 +-
 arch/arm/mach-gemini/time.c                     |  219 ++-
 arch/arm/mach-imx/3ds_debugboard.c              |    2 +-
 arch/arm/mach-imx/epit.c                        |   67 +-
 arch/arm/mach-imx/mach-imx7d.c                  |    2 +-
 arch/arm/mach-imx/mach-mx31ads.c                |    2 +-
 arch/arm/mach-iop13xx/irq.c                     |    2 +-
 arch/arm/mach-iop32x/irq.c                      |    2 +-
 arch/arm/mach-iop33x/irq.c                      |    2 +-
 arch/arm/mach-ixp4xx/common.c                   |   70 +-
 arch/arm/mach-ks8695/irq.c                      |    2 +-
 arch/arm/mach-ks8695/time.c                     |   43 +-
 arch/arm/mach-lpc32xx/irq.c                     |   10 +-
 arch/arm/mach-lpc32xx/phy3250.c                 |    4 +-
 arch/arm/mach-lpc32xx/timer.c                   |   40 +-
 arch/arm/mach-mmp/mmp-dt.c                      |    4 +-
 arch/arm/mach-mmp/mmp2-dt.c                     |    2 +-
 arch/arm/mach-mmp/time.c                        |   29 +-
 arch/arm/mach-mvebu/pmsu.c                      |    4 +-
 arch/arm/mach-mxs/mach-mxs.c                    |    4 +-
 arch/arm/mach-netx/generic.c                    |    2 +-
 arch/arm/mach-netx/time.c                       |   61 +-
 arch/arm/mach-nomadik/cpu-8815.c                |   41 +-
 arch/arm/mach-omap1/fpga.c                      |    2 +-
 arch/arm/mach-omap1/irq.c                       |    2 +-
 arch/arm/mach-omap1/time.c                      |   35 +-
 arch/arm/mach-omap1/timer32k.c                  |   33 +-
 arch/arm/mach-omap2/Kconfig                     |   20 -
 arch/arm/mach-omap2/Makefile                    |    3 -
 arch/arm/mach-omap2/board-omap3logic.c          |  249 ----
 arch/arm/mach-omap2/board-omap3pandora.c        |  633 --------
 arch/arm/mach-omap2/prm_common.c                |    2 +-
 arch/arm/mach-omap2/timer.c                     |   48 +-
 arch/arm/mach-omap2/vc.c                        |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c   |    2 +-
 arch/arm/mach-omap2/voltagedomains54xx_data.c   |    2 +-
 arch/arm/mach-orion5x/dns323-setup.c            |    4 +-
 arch/arm/mach-orion5x/tsx09-common.c            |    4 +-
 arch/arm/mach-pxa/balloon3.c                    |   16 +-
 arch/arm/mach-pxa/cm-x2xx-pci.c                 |    3 +-
 arch/arm/mach-pxa/irq.c                         |    1 -
 arch/arm/mach-pxa/lpd270.c                      |    5 +-
 arch/arm/mach-pxa/pcm990-baseboard.c            |    5 +-
 arch/arm/mach-pxa/pxa-dt.c                      |    4 +-
 arch/arm/mach-pxa/pxa3xx.c                      |    2 +-
 arch/arm/mach-pxa/viper.c                       |    5 +-
 arch/arm/mach-pxa/zeus.c                        |    5 +-
 arch/arm/mach-realview/realview-dt.c            |    2 +-
 arch/arm/mach-rpc/ecard.c                       |    2 +-
 arch/arm/mach-rpc/irq.c                         |   16 +-
 arch/arm/mach-s3c24xx/Kconfig                   |    5 +
 arch/arm/mach-s3c24xx/Makefile                  |    1 +
 arch/arm/mach-s3c24xx/bast-irq.c                |    2 +-
 .../include/plat => mach-s3c24xx}/fb-core.h     |    2 -
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c         |    2 +-
 .../include/plat => mach-s3c24xx}/nand-core.h   |    3 +-
 arch/arm/mach-s3c24xx/s3c2412.c                 |    2 +-
 arch/arm/mach-s3c24xx/s3c2416.c                 |    6 +-
 arch/arm/mach-s3c24xx/s3c2443.c                 |    7 +-
 arch/arm/mach-s3c24xx/s3c244x.c                 |    2 +-
 .../setup-camif.c                               |    0
 .../include/plat => mach-s3c24xx}/spi-core.h    |    0
 arch/arm/mach-s3c64xx/Kconfig                   |    6 +
 arch/arm/mach-s3c64xx/Makefile                  |    2 +
 .../include/plat => mach-s3c64xx}/ata-core.h    |    3 +-
 .../include/plat => mach-s3c64xx}/backlight.h   |    3 +-
 arch/arm/mach-s3c64xx/common.c                  |    6 +-
 .../dev-backlight.c                             |    6 +-
 .../include/plat => mach-s3c64xx}/irq-uart.h    |    3 +-
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c         |    5 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |    2 +-
 .../plat => mach-s3c64xx}/onenand-core.h        |    2 -
 .../plat => mach-s3c64xx}/regs-usb-hsotg-phy.h  |    3 +-
 arch/arm/mach-s3c64xx/s3c6400.c                 |    2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                 |    4 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c           |    2 +-
 .../plat => mach-s3c64xx}/watchdog-reset.h      |    3 +-
 arch/arm/mach-sa1100/neponset.c                 |    4 +-
 arch/arm/mach-shmobile/Kconfig                  |   47 -
 arch/arm/mach-shmobile/Makefile                 |   14 +-
 arch/arm/mach-shmobile/Makefile.boot            |    3 -
 arch/arm/mach-shmobile/board-armadillo800eva.c  | 1365 ------------------
 arch/arm/mach-shmobile/board-bockw-reference.c  |    2 +-
 arch/arm/mach-shmobile/board-bockw.c            |    2 +-
 arch/arm/mach-shmobile/board-kzm9g.c            |  916 ------------
 arch/arm/mach-shmobile/board-marzen-reference.c |   56 -
 arch/arm/mach-shmobile/board-marzen.c           |  347 -----
 arch/arm/mach-shmobile/clock-r8a7740.c          |  675 ---------
 arch/arm/mach-shmobile/clock-r8a7779.c          |  271 ----
 arch/arm/mach-shmobile/clock-sh73a0.c           |  752 ----------
 arch/arm/mach-shmobile/dma-register.h           |   84 --
 .../mach-shmobile/include/mach/head-kzm9g.txt   |  410 ------
 arch/arm/mach-shmobile/include/mach/zboot.h     |   19 -
 .../mach-shmobile/include/mach/zboot_macros.h   |  108 --
 arch/arm/mach-shmobile/intc-sh73a0.c            |  337 -----
 arch/arm/mach-shmobile/platsmp-apmu.c           |    4 +-
 arch/arm/mach-shmobile/pm-r8a7740.c             |  129 --
 arch/arm/mach-shmobile/pm-r8a7779.c             |    4 +-
 arch/arm/mach-shmobile/pm-rcar.c                |  105 +-
 arch/arm/mach-shmobile/pm-rcar.h                |   12 +-
 arch/arm/mach-shmobile/pm-rmobile.c             |   49 +-
 arch/arm/mach-shmobile/pm-rmobile.h             |   30 -
 arch/arm/mach-shmobile/pm-sh73a0.c              |   32 -
 arch/arm/mach-shmobile/r8a7740.h                |   58 -
 arch/arm/mach-shmobile/r8a7779.h                |   19 -
 arch/arm/mach-shmobile/setup-r7s72100.c         |    2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c          |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c          |  680 +--------
 arch/arm/mach-shmobile/setup-r8a7778.c          |    2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |  683 +--------
 arch/arm/mach-shmobile/setup-r8a7791.c          |    2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |    2 -
 arch/arm/mach-shmobile/setup-sh73a0.c           |  741 +---------
 arch/arm/mach-shmobile/sh73a0.h                 |   83 --
 arch/arm/mach-shmobile/smp-r8a7779.c            |   21 +-
 arch/arm/mach-shmobile/smp-r8a7790.c            |    4 +-
 arch/arm/mach-shmobile/smp-sh73a0.c             |    8 -
 arch/arm/mach-shmobile/timer.c                  |   12 -
 arch/arm/mach-spear/time.c                      |   91 +-
 arch/arm/mach-sti/board-dt.c                    |    2 +-
 arch/arm/mach-ux500/Makefile                    |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c                |    1 -
 arch/arm/mach-ux500/headsmp.S                   |   37 -
 arch/arm/mach-ux500/platsmp.c                   |  132 +-
 arch/arm/mach-ux500/setup.h                     |    1 -
 arch/arm/mach-w90x900/irq.c                     |    2 +-
 arch/arm/mach-w90x900/time.c                    |   51 +-
 arch/arm/mach-zx/zx296702.c                     |    2 +-
 arch/arm/plat-iop/time.c                        |   70 +-
 arch/arm/plat-orion/gpio.c                      |    9 +-
 arch/arm/plat-orion/time.c                      |   93 +-
 arch/arm/plat-samsung/Kconfig                   |   17 -
 arch/arm/plat-samsung/Makefile                  |    5 -
 .../arm/plat-samsung/include/plat/keypad-core.h |   31 -
 drivers/irqchip/irq-sa11x0.c                    |    1 -
 drivers/video/fbdev/ep93xx-fb.c                 |   30 +-
 include/linux/platform_data/video-ep93xx.h      |    8 -
 196 files changed, 1281 insertions(+), 10483 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-shmobile.S
 delete mode 100644 arch/arm/configs/armadillo800eva_defconfig
 delete mode 100644 arch/arm/configs/kzm9g_defconfig
 delete mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-ep93xx/timer-ep93xx.c
 rename arch/arm/{plat-samsung/include/plat => mach-exynos}/regs-srom.h (96%)
 rename arch/arm/{plat-samsung => mach-exynos}/s5p-dev-mfc.c (100%)
 delete mode 100644 arch/arm/mach-omap2/board-omap3logic.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3pandora.c
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/fb-core.h (93%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/nand-core.h (93%)
 rename arch/arm/{plat-samsung => mach-s3c24xx}/setup-camif.c (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c24xx}/spi-core.h (100%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/ata-core.h (92%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/backlight.h (92%)
 rename arch/arm/{plat-samsung => mach-s3c64xx}/dev-backlight.c (98%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/irq-uart.h (90%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/onenand-core.h (95%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/regs-usb-hsotg-phy.h (96%)
 rename arch/arm/{plat-samsung/include/plat => mach-s3c64xx}/watchdog-reset.h (91%)
 delete mode 100644 arch/arm/mach-shmobile/board-armadillo800eva.c
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g.c
 delete mode 100644 arch/arm/mach-shmobile/board-marzen-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-marzen.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7779.c
 delete mode 100644 arch/arm/mach-shmobile/clock-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/dma-register.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt
 delete mode 100644 arch/arm/mach-shmobile/include/mach/zboot.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/zboot_macros.h
 delete mode 100644 arch/arm/mach-shmobile/intc-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7740.c
 delete mode 100644 arch/arm/mach-shmobile/pm-sh73a0.c
 delete mode 100644 arch/arm/mach-shmobile/r8a7740.h
 delete mode 100644 arch/arm/mach-ux500/headsmp.S
 delete mode 100644 arch/arm/plat-samsung/include/plat/keypad-core.h
