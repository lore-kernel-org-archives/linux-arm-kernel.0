From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:02:26 +0100
Subject: [GIT PULL 2/7] ARM: SoC platform updates for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <5367389.2DcRufo4zX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 44c29b83de1770910b9f4d53bf78f6118da5165f:

  Merge tag 'zynq-soc-for-4.10' of https://github.com/Xilinx/linux-xlnx into next/soc (2016-12-07 12:35:46 -0800)

----------------------------------------------------------------
ARM: SoC platform updates for v4.10

These are updates for platform specific code on 32-bit ARM machines,
essentially anything that can not (yet) be expressed using DT files.

Noteworthy changes include:

- Added support for the TI DRA71x family of SoCs in mach-omap2,
  this is an new variant of the the DRA72x/DRA74x automotive
  infotainment chips we already supported for a while.

- Added support for the ST STM32F746 SoC, the first Cortex-M7
  based microcontroller we support, related to the smaller
  STM32F4 family.

- Renesas adds support for r8a7743 and r8a7745 in mach-shmobile,
  see http://elinux.org/RZ-G

- SMP is now supported on the OX820 platform

- A lot of code in mach-omap2 gets removed as a follow-up to
  removing support for board files in the previous release

- Davinci has some new work to improve USB support

- For i.MX, the performance monitor now supports profiling the
  memory controller using 'perf'

Conflicts:
arch/arm/mach-shmobile/setup-rcar-gen2.c: rcar_gen2_clocks_init()
is gone, calling of_clk_init(NULL) is sufficient now.

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: davinci: da8xx: Remove duplicated defines

Alexandre TORGUE (2):
      ARM: mach-stm32: Add a new SOC - STM32F746
      ARM: Kconfig: Introduce MACH_STM32F746 flag

Andrey Smirnov (1):
      ARM: imx: Drop errata 769419 for Vybrid

Arnd Bergmann (6):
      Merge tag 'oxnas-arm-soc-for-4.10-v2' of https://github.com/OXNAS/linux into next/soc
      Merge tag 'mvebu-soc-4.10-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'davinci-for-v4.10/cleanup-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'davinci-for-v4.10/soc-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'davinci-for-v4.10/soc-3' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'arm-soc/for-4.10/soc' of http://github.com/Broadcom/stblinux into next/soc

Ashley Hughes (1):
      ARM: orion5x: remove legacy support of ls-chl

Axel Haslam (6):
      ARM: davinci: da8xx: Add full regulator constraints for non-DT boot
      ARM: davinci: da8xx: register USB PHY clocks in the DT file
      ARM: davinci: da8xx: Fix ohci device name
      ARM: davinci: hawk: use gpio descriptor for mmc pins
      ARM: davinci: da850-evm: use gpio descriptor for mmc pins
      ARM: davinci: da830-evm: use gpio descriptor for mmc pins

David Lechner (5):
      ARM: davinci: da8xx: Add CFGCHIP syscon platform device
      ARM: davinci: da8xx: Add USB PHY platform device
      ARM: davinci: da8xx: Add USB device names to clock lookup tables
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for USB phy
      ARM: davinci: da8xx: add usb phy clocks

Frank Li (1):
      ARM: imx: mmdc perf function support i.MX6QP

Geert Uytterhoeven (4):
      ARM: shmobile: Sort Kconfig selections
      ARM: shmobile: r8a7794/alt: Add board part number to DT bindings
      ARM: shmobile: r8a7793/gose: Add board part number to DT bindings
      ARM: shmobile: r8a7779/marzen: Add board part number to DT bindings

Javier Martinez Canillas (2):
      ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC support
      ARM: OMAP2+: Remove legacy board-flash.c

Joel Fernandes (4):
      ARM: DRA7: hwmod: Add data for DES IP
      ARM: DRA7: hwmod: Add data for AES IP
      ARM: DRA7: hwmod: Add data for RNG IP
      ARM: OMAP: DRA7xx: Make L4SEC clock domain SWSUP only

Karl Beldan (1):
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for lcdc

Kevin Hilman (4):
      ARM: davinci: PM: rework init, remove platform device
      ARM: davinci: PM: cleanup: remove references to pdata
      ARM: davinci: PM: support da8xx DT platforms
      ARM: davinci: PM: fix build when da850 not compiled in

Kyle Roeschley (1):
      ARM: zynq: Reserve correct amount of non-DMA RAM

Laurent Pinchart (1):
      ARM: shmobile: Consolidate R8A7743 and R8A779[234] machine definitions

Linus Walleij (1):
      ARM: integrator: drop EBI access use syscon

Lokesh Vutla (4):
      ARM: DRA7: hwmod: Add data for SHA IP
      ARM: AM43xx: hwmod: Add data for DES
      ARM: AMx3xx: hwmod: Add data for RNG
      ARM: OMAP2+: board-generic: add support for DRA71x family

Lorenzo Pieralisi (2):
      ARM: vexpress: refine MCPM smp operations override criteria
      drivers: cci: add missing CCI port availability firmware check

Markus Elfring (3):
      ARM/orion/gpio: Replace three seq_printf() calls by seq_puts() in orion_gpio_dbg_show()
      ARM: OMAP2+: mux: Replace three seq_printf() calls by seq_puts()
      ARM: OMAP2+: mux: Use seq_putc() in omap_mux_dbg_signal_show()

Masahiro Yamada (1):
      ARM: mediatek: clean up mach-mediatek/Makefile

Neil Armstrong (2):
      ARM: oxnas: Add OX820 SMP support
      ARM: oxnas: Add OX820 config and makefile entry

Nicolae Rosia (5):
      ARM: OMAP4: kill omap4_pmic_init and omap4_pmic_get_config
      ARM: OMAP3: kill omap3_pmic_get_config and twl_{get,set}_voltage
      ARM: OMAP3: kill omap3_pmic_init
      ARM: OMAP2: kill omap2_pmic_init
      ARM: OMAP: kill omap_pmic_init

Niklas Cassel (1):
      ARM: ARTPEC-6: add select MFD_SYSCON to MACH_ARTPEC6

Nishanth Menon (1):
      ARM: DRA7: hwmod: Do not register RTC on DRA71

Olof Johansson (14):
      Merge tag 'vexpress-fixes-4.10' of git://git.kernel.org/.../sudeep.holla/linux into next/soc
      Merge tag 'davinci-for-v4.10/cleanup' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'davinci-for-v4.10/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'renesas-soc-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'lpc32xx-cleanup-v4.10' of https://github.com/sylemieux/linux-lpc32xx into next/soc
      Merge tag 'pxa-for-4.10' of https://github.com/rjarzmik/linux into next/soc
      Merge tag 'v4.9-next-kconfig' of https://github.com/mbgg/linux-mediatek into next/soc
      Merge tag 'imx-soc-4.10' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'soc-for-4.10-1' of git://git.kernel.org/.../atorgue/stm32 into next/soc
      Merge tag 'omap-for-v4.10/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.10/legacy-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'renesas-soc2-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'mvebu-drivers-4.10-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'zynq-soc-for-4.10' of https://github.com/Xilinx/linux-xlnx into next/soc

Peter Chen (1):
      ARM: imx: mach-imx6ul: add imx6ull support

Peter Ujfalusi (4):
      ARM: davinci: devices-da8xx: Remove DMA resources for MMC and SPI
      ARM: davinci: devices: Remove DMA resources for MMC
      ARM: davinci: dm355: Remove DMA resources for SPI
      ARM: davinci: dm365: Remove DMA resources for SPI

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add back handler ignoring external imprecise aborts

Robert Jarzmik (8):
      ARM: sa11x0/pxa: acquire timer rate from the clock rate
      watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
      ARM: sa11x0/pxa: get rid of get_clock_tick_rate
      ARM: pxa: pxa_cplds: honor probe deferral
      ARM: pxa: mioa701: use the new pxa_camera platform_data
      ARM: pxa: ezx: use the new pxa_camera platform_data
      ARM: pxa: em-x270: use the new pxa_camera platform_data
      ARM: pxa: fix pxa25x interrupt init

Russell King - ARM Linux (1):
      clk: pxa25x: OSTIMER0 clocks from the main oscillator

Santosh Shilimkar (1):
      ARM: OMAP5: Add basic cpuidle MPU CSWR support

Sergei Shtylyov (4):
      ARM: shmobile: r8a7743: basic SoC support
      ARM: shmobile: document SK-RZG1M board
      ARM: shmobile: r8a7745: basic SoC support
      ARM: shmobile: document SK-RZG1E board

Simon Horman (2):
      ARM: shmobile: only call rcar_gen2_clocks_init() if present
      ARM: shmobile: select errata 798181 for SoCs with CA15 cores

Tony Lindgren (16):
      ARM: OMAP5: Fix build for PM code
      ARM: OMAP5: Fix mpuss_early_init
      ARM: OMAP4+: Fix bad fallthrough for cpuidle
      ARM: OMAP2+: Remove legacy serial.c
      ARM: OMAP2+: Remove legacy i2c.c platform init code
      ARM: OMAP2+: Remove legacy PM init
      ARM: OMAP2+: Remove legacy twl4030 platform init code
      ARM: OMAP2+: Remove legacy usb-host.c platform init code
      ARM: OMAP2+: Remove legacy muxing for usb-tusb6010.c
      ARM: OMAP2+: Remove legacy usb-musb.c platform init code
      ARM: OMAP2+: Remove legacy hwmod mux code
      ARM: OMAP2+: Remove legacy mux code
      ARM: OMAP2+: Remove legacy data from hwmod for omap3
      ARM: OMAP2+: Drop legacy ads7846 init
      ARM: OMAP2+: Drop legacy sdram timings
      Merge branch 'omap-for-v4.10/cpuidle-v2' into omap-for-v4.10/soc

Vladimir Zapolskiy (2):
      ARM: lpc32xx: remove unused header file mach/irqs.h
      ARM: lpc32xx: remove unused header file clock.h

Wei Yongjun (1):
      ARM: pxa: remove duplicated include from spitz.c

Zhengyu Shen (1):
      ARM: imx: Added perf functionality to mmdc driver

 Documentation/arm/stm32/overview.txt               |    3 +-
 Documentation/arm/stm32/stm32f746-overview.txt     |   34 +
 .../devicetree/bindings/arm/omap/omap.txt          |    6 +
 Documentation/devicetree/bindings/arm/shmobile.txt |   14 +-
 arch/arm/Kconfig                                   |    5 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-artpec/Kconfig                       |    1 +
 arch/arm/mach-bcm/bcm_5301x.c                      |   28 +
 arch/arm/mach-davinci/Makefile                     |    4 +-
 arch/arm/mach-davinci/board-da830-evm.c            |   95 +-
 arch/arm/mach-davinci/board-da850-evm.c            |   56 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |   20 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   68 +-
 arch/arm/mach-davinci/common.c                     |    1 -
 arch/arm/mach-davinci/da830.c                      |    4 +-
 arch/arm/mach-davinci/da850.c                      |   42 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |   16 +
 arch/arm/mach-davinci/devices-da8xx.c              |   57 +-
 arch/arm/mach-davinci/devices.c                    |    3 -
 arch/arm/mach-davinci/dm355.c                      |    8 -
 arch/arm/mach-davinci/dm365.c                      |    8 -
 arch/arm/mach-davinci/include/mach/da8xx.h         |    7 +-
 arch/arm/mach-davinci/pm.c                         |  102 +-
 arch/arm/mach-davinci/usb-da8xx.c                  |  280 ++-
 arch/arm/mach-imx/Kconfig                          |    1 -
 arch/arm/mach-imx/mach-imx6ul.c                    |    1 +
 arch/arm/mach-imx/mmdc.c                           |  495 ++++-
 arch/arm/mach-integrator/integrator_ap.c           |   54 +-
 arch/arm/mach-lpc32xx/clock.h                      |   38 -
 arch/arm/mach-lpc32xx/common.h                     |    1 -
 arch/arm/mach-lpc32xx/include/mach/irqs.h          |  117 --
 arch/arm/mach-lpc32xx/pm.c                         |    1 -
 arch/arm/mach-mediatek/Makefile                    |    6 +-
 arch/arm/mach-omap1/Kconfig                        |   26 +
 arch/arm/mach-omap1/i2c.c                          |   83 +
 arch/arm/mach-omap2/Makefile                       |   18 +-
 arch/arm/mach-omap2/board-flash.c                  |  242 ---
 arch/arm/mach-omap2/board-flash.h                  |   56 -
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |    2 +-
 arch/arm/mach-omap2/common-board-devices.c         |  102 -
 arch/arm/mach-omap2/common-board-devices.h         |    8 -
 arch/arm/mach-omap2/common.h                       |   47 +-
 arch/arm/mach-omap2/cpuidle44xx.c                  |   80 +-
 arch/arm/mach-omap2/devices.c                      |    1 -
 arch/arm/mach-omap2/dss-common.c                   |   37 -
 arch/arm/mach-omap2/dss-common.h                   |   13 -
 arch/arm/mach-omap2/gpmc-smsc911x.c                |  100 -
 arch/arm/mach-omap2/gpmc-smsc911x.h                |   35 -
 arch/arm/mach-omap2/hsmmc.c                        |   88 -
 arch/arm/mach-omap2/i2c.c                          |   97 -
 arch/arm/mach-omap2/io.c                           |    4 +-
 arch/arm/mach-omap2/msdi.c                         |    1 -
 arch/arm/mach-omap2/mux.c                          | 1153 -----------
 arch/arm/mach-omap2/mux.h                          |  352 ----
 arch/arm/mach-omap2/mux34xx.c                      | 2061 --------------------
 arch/arm/mach-omap2/mux34xx.h                      |  402 ----
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |   37 +-
 arch/arm/mach-omap2/omap4-sar-layout.h             |    2 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  107 +-
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  149 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  201 +-
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    4 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    1 -
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |    2 +
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |    8 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   29 +
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   35 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  787 +-------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   34 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  182 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   15 -
 arch/arm/mach-omap2/pdata-quirks.c                 |    1 -
 arch/arm/mach-omap2/pm.c                           |   66 +-
 arch/arm/mach-omap2/pm44xx.c                       |    2 +-
 arch/arm/mach-omap2/prcm43xx.h                     |    2 +
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   51 -
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   55 -
 arch/arm/mach-omap2/sdram-nokia.c                  |  299 ---
 arch/arm/mach-omap2/sdram-nokia.h                  |   12 -
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |   51 -
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   54 -
 arch/arm/mach-omap2/serial.c                       |  332 ----
 arch/arm/mach-omap2/twl-common.c                   |  564 ------
 arch/arm/mach-omap2/twl-common.h                   |   66 -
 arch/arm/mach-omap2/usb-host.c                     |  496 -----
 arch/arm/mach-omap2/usb-musb.c                     |  106 -
 arch/arm/mach-omap2/usb-tusb6010.c                 |   21 -
 arch/arm/mach-orion5x/Kconfig                      |    7 -
 arch/arm/mach-orion5x/Makefile                     |    1 -
 arch/arm/mach-orion5x/ls-chl-setup.c               |  331 ----
 arch/arm/mach-oxnas/Kconfig                        |   30 +-
 arch/arm/mach-oxnas/Makefile                       |    2 +
 arch/arm/mach-oxnas/headsmp.S                      |   26 +
 arch/arm/mach-oxnas/hotplug.c                      |  109 ++
 arch/arm/mach-oxnas/platsmp.c                      |  102 +
 arch/arm/mach-pxa/corgi.c                          |    1 -
 arch/arm/mach-pxa/em-x270.c                        |   89 +-
 arch/arm/mach-pxa/ezx.c                            |  176 +-
 arch/arm/mach-pxa/generic.c                        |   18 +-
 arch/arm/mach-pxa/include/mach/hardware.h          |    2 -
 arch/arm/mach-pxa/mioa701.c                        |   13 +-
 arch/arm/mach-pxa/pxa25x.c                         |    2 +-
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 |   11 +-
 arch/arm/mach-pxa/spitz.c                          |    1 -
 arch/arm/mach-sa1100/generic.c                     |    2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h       |    4 -
 arch/arm/mach-shmobile/Kconfig                     |   20 +-
 arch/arm/mach-shmobile/Makefile                    |    3 -
 arch/arm/mach-shmobile/setup-r8a7792.c             |   35 -
 arch/arm/mach-shmobile/setup-r8a7793.c             |   33 -
 arch/arm/mach-shmobile/setup-r8a7794.c             |   33 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   45 +-
 arch/arm/mach-stm32/board-dt.c                     |    1 +
 arch/arm/mach-vexpress/platsmp.c                   |   34 +-
 arch/arm/mach-zynq/common.c                        |    2 +-
 arch/arm/plat-omap/Kconfig                         |   26 -
 arch/arm/plat-omap/Makefile                        |    3 -
 arch/arm/plat-omap/i2c.c                           |  116 --
 arch/arm/plat-orion/gpio.c                         |    6 +-
 drivers/bus/arm-cci.c                              |   10 +
 drivers/clk/pxa/clk-pxa25x.c                       |    2 +-
 drivers/clocksource/pxa_timer.c                    |   11 +-
 drivers/watchdog/sa1100_wdt.c                      |   24 +-
 include/clocksource/pxa.h                          |    3 +-
 include/linux/platform_data/usb-davinci.h          |   23 -
 126 files changed, 2135 insertions(+), 9579 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
 delete mode 100644 arch/arm/mach-lpc32xx/clock.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-omap2/board-flash.c
 delete mode 100644 arch/arm/mach-omap2/board-flash.h
 delete mode 100644 arch/arm/mach-omap2/common-board-devices.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.c
 delete mode 100644 arch/arm/mach-omap2/dss-common.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h
 delete mode 100644 arch/arm/mach-omap2/mux.c
 delete mode 100644 arch/arm/mach-omap2/mux.h
 delete mode 100644 arch/arm/mach-omap2/mux34xx.c
 delete mode 100644 arch/arm/mach-omap2/mux34xx.h
 delete mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
 delete mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
 delete mode 100644 arch/arm/mach-omap2/sdram-nokia.c
 delete mode 100644 arch/arm/mach-omap2/sdram-nokia.h
 delete mode 100644 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h
 delete mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
 delete mode 100644 arch/arm/mach-omap2/serial.c
 delete mode 100644 arch/arm/mach-omap2/twl-common.c
 delete mode 100644 arch/arm/mach-omap2/twl-common.h
 delete mode 100644 arch/arm/mach-omap2/usb-host.c
 delete mode 100644 arch/arm/mach-omap2/usb-musb.c
 delete mode 100644 arch/arm/mach-orion5x/ls-chl-setup.c
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/headsmp.S
 create mode 100644 arch/arm/mach-oxnas/hotplug.c
 create mode 100644 arch/arm/mach-oxnas/platsmp.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
 delete mode 100644 arch/arm/plat-omap/i2c.c
