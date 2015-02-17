From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:23 -0800
Subject: [GIT PULL 2/7] ARM: SoC cleanups
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a good healthy set of various code removals. Total net delta is 8100
lines removed.

Among the larger cleanups are:

- Removal of old Samsung S3C DMA infrastructure by Arnd
- Removal of the non-DT version of the 'lager' board by Magnus Damm
- General stale code removal on OMAP and Davinci by Rickard Strandqvist
- Removal of non-DT support on am3517 platforms by Tony Lindgren

... plus several other cleanups of various platforms across the board.



Conflicts:

arch/arm/mach-shmobile/board-lager.c: modified in 3.19-rc and removed
here. Drop it.

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/cleanup-for-linus

for you to fetch changes up to 41e229a91207afc326f9a83ba33c098c8362d303:

  ARM: sirf: drop redundant function and marco declaration

----------------------------------------------------------------

Alexandre Belloni (7):
      ARM: at91: remove unused mach/memory.h
      ARM: at91: remove useless config MACH_AT91RM9200_DT
      ARM: at91: remove useless config MACH_AT91SAM9_DT
      ARM: at91: remove useless at91_sysirq_mask_rtx
      ARM: at91: move debug-macro.S into the common space
      ARM: at91: remove useless at91rm9200_dt_initialize()
      ARM: at91: remove useless at91rm9200_set_type()

Arnd Bergmann (1):
      ARM: SAMSUNG: remove unused DMA infrastructure

Barry Song (1):
      ARM: sirf: drop redundant function and marco declaration

Boris Brezillon (1):
      ARM: at91: remove useless header file includes

Geert Uytterhoeven (1):
      ARM: shmobile: lager dts: Drop console= bootargs parameter

Laurent Pinchart (3):
      ARM: shmobile: r8a7790: Remove legacy code
      ARM: shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]
      ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]

Magnus Damm (2):
      ARM: shmobile: lager-reference: DTS-only board support
      ARM: shmobile: lager: Remove legacy board support

Mark Rutland (5):
      arm: realview: specify PMU types
      arm: pxa: specify PMUs are for XScale CPUs
      arm: iop: specify PMUs are for XScale CPUs
      arm: shmobile: specify PMUs are for ARMv7 CPUs
      arm: omap: specify PMUs are for ARMv7 CPUs

Nicolas Ferre (3):
      ARM: at91/Documentation: add a README for Atmel SoCs
      rtc: at91/Kconfig: remove useless options
      ARM: at91: remove unneeded header file

Olof Johansson (6):
      Merge tag 'renesas-lager-board-removal-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'at91-cleanup' of git://git.kernel.org/.../nferre/linux-at91 into next/cleanup
      Merge tag 'omap-for-v3.20/cleanup-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'davinci-for-v3.20/cleanup' of git://git.kernel.org/.../nsekhar/linux-davinci into next/cleanup
      Merge tag 'omap-for-v3.20/drop-legacy-3517-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'samsung-cleanup' of git://git.kernel.org/.../kgene/linux-samsung into next/cleanup

Pankaj Dubey (1):
      ARM: EXYNOS: Remove i2c sys configuration related code

Rickard Strandqvist (13):
      ARM: OMAP2+: clkt2xxx_apll.c: Remove some unused functions
      ARM: OMAP2+: cm33xx.c: Remove some unused functions
      ARM: OMAP2+: dpll44xx.c: Remove unused function
      ARM: OMAP2+: omap_hwmod.c: Remove some unused functions
      ARM: OMAP2+: powerdomain.c: Remove some unused functions
      ARM: OMAP2+: voltage: Remove some unused functions
      ARM: OMAP2+: omap-pm-noop.c: Remove some unused functions
      ARM: OMAP1: irq.c: Remove unused function
      ARM: OMAP1: timer32k.c: Remove unused function
      ARM: OMAP: dma.c: Remove unused function
      ARM: davinci: serial.c: remove unused serial_read_reg()
      ARM: versatile: core: Remove unused function
      ARM: davinci: Remove CDCE949 driver

Tero Kristo (3):
      ARM: OMAP2: clock: remove unused apll code
      ARM: OMAP2: CM: remove unused PLL functions
      ARM: OMAP3+: PRM: remove prm_get_reset_sources declaration from headers

Tony Lindgren (6):
      ARM: OMAP3: Remove legacy support for am3517-evm
      ARM: OMAP3: Remove legacy support for am3517crane
      ARM: OMAP3: Remove cm-t3517 legacy support
      ARM: OMAP3: Remove legacy support for am35xx-emac
      ARM: OMAP2+: Remove unused ti81xx platform init code
      ARM: OMAP3: Add back Kconfig option MACH_OMAP3517EVM for ASoC


 Documentation/arm/Atmel/README                  |  124 ++
 Documentation/arm/Samsung-S3C24XX/DMA.txt       |   46 -
 MAINTAINERS                                     |    2 +-
 arch/arm/Kconfig.debug                          |    9 +-
 arch/arm/boot/dts/Makefile                      |    1 -
 arch/arm/boot/dts/r8a7790-lager.dts             |    6 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    4 +-
 arch/arm/configs/lager_defconfig                |  150 --
 arch/arm/configs/shmobile_defconfig             |    1 -
 .../mach/debug-macro.S => include/debug/at91.S} |   19 +-
 arch/arm/mach-at91/Kconfig                      |    8 -
 arch/arm/mach-at91/Makefile                     |    6 +-
 arch/arm/mach-at91/at91sam9260.c                |    2 -
 arch/arm/mach-at91/at91sam9261.c                |    2 -
 arch/arm/mach-at91/at91sam9263.c                |    3 -
 arch/arm/mach-at91/at91sam9g45.c                |    4 -
 arch/arm/mach-at91/at91sam9n12.c                |    6 -
 arch/arm/mach-at91/at91sam9rl.c                 |    4 -
 arch/arm/mach-at91/at91sam9x5.c                 |   10 -
 arch/arm/mach-at91/board-dt-rm9200.c            |    2 +-
 arch/arm/mach-at91/generic.h                    |    6 -
 arch/arm/mach-at91/include/mach/at91_pio.h      |   80 -
 arch/arm/mach-at91/include/mach/at91_rtt.h      |   35 -
 arch/arm/mach-at91/include/mach/memory.h        |   26 -
 arch/arm/mach-at91/sama5d3.c                    |    6 -
 arch/arm/mach-at91/setup.c                      |   18 -
 arch/arm/mach-at91/sysirq_mask.c                |   75 -
 arch/arm/mach-davinci/Makefile                  |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        |   31 -
 arch/arm/mach-davinci/cdce949.c                 |  295 ----
 arch/arm/mach-davinci/include/mach/cdce949.h    |   19 -
 arch/arm/mach-davinci/serial.c                  |   10 -
 arch/arm/mach-exynos/exynos.c                   |   39 +-
 arch/arm/mach-exynos/include/mach/dma.h         |   26 -
 arch/arm/mach-exynos/include/mach/map.h         |    3 -
 arch/arm/mach-exynos/pm.c                       |    3 +-
 arch/arm/mach-exynos/regs-sys.h                 |   22 -
 arch/arm/mach-exynos/suspend.c                  |    7 -
 arch/arm/mach-omap1/irq.c                       |    5 -
 arch/arm/mach-omap1/timer32k.c                  |    5 -
 arch/arm/mach-omap2/Kconfig                     |   12 -
 arch/arm/mach-omap2/Makefile                    |    9 -
 arch/arm/mach-omap2/am35xx-emac.c               |  114 --
 arch/arm/mach-omap2/am35xx-emac.h               |   15 -
 arch/arm/mach-omap2/am35xx.h                    |   46 -
 arch/arm/mach-omap2/board-am3517crane.c         |  150 --
 arch/arm/mach-omap2/board-am3517evm.c           |  373 -----
 arch/arm/mach-omap2/board-cm-t3517.c            |  335 ----
 arch/arm/mach-omap2/cclock3xxx_data.c           |    6 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c             |  142 --
 arch/arm/mach-omap2/clock.h                     |    1 -
 arch/arm/mach-omap2/clock2xxx.h                 |   11 -
 arch/arm/mach-omap2/cm2xxx.c                    |   10 -
 arch/arm/mach-omap2/cm2xxx.h                    |    2 -
 arch/arm/mach-omap2/cm33xx.c                    |   21 -
 arch/arm/mach-omap2/dpll44xx.c                  |   20 -
 arch/arm/mach-omap2/omap-pm-noop.c              |  196 ---
 arch/arm/mach-omap2/omap-pm.h                   |  192 ---
 arch/arm/mach-omap2/omap_hwmod.c                |  232 ---
 arch/arm/mach-omap2/omap_hwmod.h                |   16 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |   33 +-
 arch/arm/mach-omap2/omap_phy_internal.c         |   35 -
 arch/arm/mach-omap2/pdata-quirks.c              |    1 -
 arch/arm/mach-omap2/pmu.c                       |    5 +-
 arch/arm/mach-omap2/powerdomain.c               |   82 -
 arch/arm/mach-omap2/powerdomain.h               |    5 -
 arch/arm/mach-omap2/prm3xxx.h                   |    1 -
 arch/arm/mach-omap2/prm44xx_54xx.h              |    1 -
 arch/arm/mach-omap2/usb-musb.c                  |   12 +-
 arch/arm/mach-omap2/usb.h                       |    2 -
 arch/arm/mach-omap2/voltage.c                   |  110 --
 arch/arm/mach-omap2/voltage.h                   |   13 -
 arch/arm/mach-prima2/common.h                   |   15 -
 arch/arm/mach-pxa/devices.c                     |    2 +-
 arch/arm/mach-realview/realview_eb.c            |    3 +-
 arch/arm/mach-realview/realview_pb1176.c        |    2 +-
 arch/arm/mach-realview/realview_pb11mp.c        |    2 +-
 arch/arm/mach-realview/realview_pba8.c          |    2 +-
 arch/arm/mach-realview/realview_pbx.c           |    2 +-
 arch/arm/mach-s3c24xx/Kconfig                   |   42 -
 arch/arm/mach-s3c24xx/Makefile                  |    7 -
 arch/arm/mach-s3c24xx/dma-s3c2410.c             |  182 ---
 arch/arm/mach-s3c24xx/dma-s3c2412.c             |  150 --
 arch/arm/mach-s3c24xx/dma-s3c2440.c             |  193 ---
 arch/arm/mach-s3c24xx/dma-s3c2443.c             |  179 ---
 arch/arm/mach-s3c24xx/dma.c                     | 1465 ------------------
 arch/arm/mach-s3c24xx/include/mach/dma.h        |  159 --
 arch/arm/mach-s3c64xx/include/mach/dma.h        |   15 -
 arch/arm/mach-shmobile/Kconfig                  |   20 -
 arch/arm/mach-shmobile/Makefile                 |    3 -
 arch/arm/mach-shmobile/Makefile.boot            |    1 -
 arch/arm/mach-shmobile/board-lager-reference.c  |   39 -
 arch/arm/mach-shmobile/board-lager.c            |  840 ----------
 arch/arm/mach-shmobile/clock-r8a7790.c          |  459 ------
 arch/arm/mach-shmobile/r8a7790.h                |   28 -
 arch/arm/mach-shmobile/setup-r8a7740.c          |    2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c          |  284 +---
 arch/arm/mach-shmobile/setup-sh73a0.c           |    2 +-
 arch/arm/mach-versatile/core.c                  |   37 -
 arch/arm/plat-iop/pmu.c                         |    2 +-
 arch/arm/plat-omap/dma.c                        |    8 -
 arch/arm/plat-samsung/Kconfig                   |   15 -
 arch/arm/plat-samsung/Makefile                  |    6 -
 arch/arm/plat-samsung/dma-ops.c                 |  146 --
 arch/arm/plat-samsung/dma.c                     |   84 -
 arch/arm/plat-samsung/include/plat/dma-core.h   |   22 -
 arch/arm/plat-samsung/include/plat/dma-ops.h    |   69 -
 arch/arm/plat-samsung/include/plat/dma-pl330.h  |  121 --
 .../arm/plat-samsung/include/plat/dma-s3c24xx.h |   73 -
 arch/arm/plat-samsung/include/plat/dma.h        |  130 --
 arch/arm/plat-samsung/include/plat/regs-dma.h   |  151 --
 arch/arm/plat-samsung/s3c-dma-ops.c             |  146 --
 drivers/dma/Kconfig                             |    2 +-
 drivers/rtc/Kconfig                             |   28 -
 114 files changed, 177 insertions(+), 8286 deletions(-)
 create mode 100644 Documentation/arm/Atmel/README
 delete mode 100644 Documentation/arm/Samsung-S3C24XX/DMA.txt
 delete mode 100644 arch/arm/configs/lager_defconfig
 rename arch/arm/{mach-at91/include/mach/debug-macro.S => include/debug/at91.S} (68%)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_pio.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_rtt.h
 delete mode 100644 arch/arm/mach-at91/include/mach/memory.h
 delete mode 100644 arch/arm/mach-at91/sysirq_mask.c
 delete mode 100644 arch/arm/mach-davinci/cdce949.c
 delete mode 100644 arch/arm/mach-davinci/include/mach/cdce949.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/dma.h
 delete mode 100644 arch/arm/mach-exynos/regs-sys.h
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h
 delete mode 100644 arch/arm/mach-omap2/am35xx.h
 delete mode 100644 arch/arm/mach-omap2/board-am3517crane.c
 delete mode 100644 arch/arm/mach-omap2/board-am3517evm.c
 delete mode 100644 arch/arm/mach-omap2/board-cm-t3517.c
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma.c
 delete mode 100644 arch/arm/mach-shmobile/board-lager-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-lager.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7790.c
 delete mode 100644 arch/arm/plat-samsung/dma-ops.c
 delete mode 100644 arch/arm/plat-samsung/dma.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-core.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-ops.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-pl330.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-dma.h
 delete mode 100644 arch/arm/plat-samsung/s3c-dma-ops.c
