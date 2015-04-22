From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:09 -0700
Subject: [GIT PULL 2/9] ARM: SoC cleanups for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've got a fairly large cleanup branch this time. The bulk of this is removal
of non-DT platforms of several flavors:

- Atmel at91 platforms go full-DT, with removal of remaining board-file based
support
- OMAP removes legacy board files for three more platforms
- Removal of non-DT mach-msm, newer Qualcomm platforms now live in mach-qcom
- Freescale i.MX25 also removes non-DT platform support

Most of the rest of the changes here are fallout from the above, i.e. for
example removal of drivers that now lack platforms, etc.


Conflicts: None

----------------------------------------------------------------

The following changes since commit 94125d56aa2549dae3bd3ac5fd7b6b8993a76a06:

  Merge tag 'armsoc-fixes' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to c4c14f393fe4991a423c21516511ff1011140143:

  Merge tag 'imx-cleanup-4.1' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into next/cleanup

----------------------------------------------------------------

Alexandre Belloni (8):
      ARM: at91: remove unused at91_ioremap_matrix and header
      ARM: at91: remove unused _matrix.h headers
      ARM: at91/dt: introduce atmel,<chip>-dbgu
      ARM: at91: at91rm9200 use SoC detection infrastructure
      ARM: at91: at91sam9: use SoC detection infrastructure
      ARM: at91: sama5 use SoC detection infrastructure
      ARM: at91: sama5d4: remove useless map_io
      ARM: at91: remove old setup

Arnd Bergmann (4):
      Merge tag 'mvebu-cleanup-4.1' of git://git.infradead.org/linux-mvebu into next/cleanup
      ARM: at91: remove NEED_MACH_IO_H
      Merge tag 'at91-cleanup2' of git://git.kernel.org/.../nferre/linux-at91 into next/cleanup
      Merge tag 'renesas-soc-cleanup2-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/cleanup

Boris BREZILLON (1):
      ARM: at91: add soc detection infrastructure

Boris Brezillon (1):
      ARM: at91: remove ksz8081 phy fixup registration for sama5d4ek board

Daniel Lezcano (1):
      ARM: shmobile: cpuidle: Remove the pointless default driver

Fabio Estevam (11):
      ARM: imx: Kconfig: Fix grammar in help text
      ARM: mx25: Remove mach-mx25_3ds board file
      ARM: imx25: Remove eukrea mx25 board files
      ARM: mx25: Convert to a dt-only platform
      ARM: mx25: Remove platform code support files
      ARM: mx25: Remove mx25_clocks_init()
      ARM: mx25: Retrieve IIM base from dt
      ARM: mx25: Remove static memory mapping
      ARM: mx25: Remove "mx25.h" header file
      ARM: mx25: Remove imxdi_rtc platform code
      ARM: imx_v4_v5_defconfig: Remove CONFIG_MACH_MX25_3DS

Gaku Inami (1):
      ARM: shmobile: Consolidate the pm code for R-Car Gen2

Geert Uytterhoeven (3):
      ARM: shmobile: Remove stray closing parenthesis in debug description
      ARM: shmobile: R-Car Gen2: CONFIG_COMMON_CLK is always set
      ARM: shmobile: r8a7740: Remove restart callback

Nicolas Ferre (3):
      Merge tag 'at91-fixes' into at91-4.1-cleanup
      Merge tag 'at91-fixes2' into at91-4.1-cleanup
      Merge tag 'at91-fixes3' into at91-4.1-cleanup

Olof Johansson (6):
      Merge tag 'davinci-for-v4.1/mcasp' of git://git.kernel.org/.../nsekhar/linux-davinci into next/cleanup
      Merge tag 'v4.1-legacy' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'renesas-pm-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'renesas-soc-cleanup3-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'qcom-cleanup-for-4.1' of git://git.kernel.org/.../galak/linux-qcom into next/cleanup
      Merge tag 'imx-cleanup-4.1' of git://git.kernel.org/.../shawnguo/linux into next/cleanup

Peter Ujfalusi (7):
      ARM: davinci: devices-da8xx: Add resource name for the McASP DMA request
      ARM: davinci: devices-da8xx: Add interrupt resource to McASP structs
      ARM: davinci: devices-da8xx: Clean up and correct the McASP device creation
      ARM: davinci: devices-da8xx: Add support for McASP2 on da830
      ARM: davinci: dm646x: Clean up the McASP DMA resources
      ARM: davinci: irqs: Correct McASP1 TX interrupt definition for DM646x
      ARM: davinci: dm646x: Add interrupt resource for McASPs

Simon Horman (2):
      ARM: shmobile: r8a7790: Correct SYSCIER value
      ARM: shmobile: r8a7791: Correct SYSCIER value

Stephen Boyd (3):
      ARM: Remove mach-msm and associated ARM architecture code
      gpio: Remove gpio-msm-v1 driver
      mmc: Remove msm_sdcc driver

Sylvain Rochet (1):
      ARM: at91/pm_slowclock: remove clocks which are already stopped when entering slow clock mode

Thomas Petazzoni (1):
      ARM: mvebu: add __initconst specifiers on DT_MACHINE_START dt_compat tables

Tony Lindgren (3):
      ARM: OMAP3: Remove legacy support for EMA-Tech Stalker board
      ARM: OMAP3: Remove legacy support for devkit8000
      ARM: OMAP2+: Remove legacy support for omap3 TouchBook

Uwe Kleine-K?nig (1):
      ARM: imx/iomux-v3: allow pad_list to be const

Wenyou Yang (12):
      ARM: at91: pm: change at91_pm_set_standby() to static
      ARM: at91/pm_slowclock: remove the unused code related with SLOWDOWN_MASTER_CLOCK
      ARM: at91: move "select SRAM" under SOC_AT91SAM9 and SOC_SAMA5
      ARM: at91/pm: remove CONFIG_AT91_SLOW_CLOCK config option
      ARM: at91/pm_slowclock: create the procedure to handle the sdram self-refresh
      ARM: at91/pm: move the copying the sram function to the sram initialization phase
      ARM: at91/pm: standby mode uses same sram function as suspend to memory mode
      ARM: at91/pm: rename file name: pm_slowclock.S --> pm_suspend.S
      ARM: at91/pm: rename function name: at91_slow_clock() --> at91_pm_suspend_sram_fn()
      ARM: at91/pm: remove unused void (*at91_pm_standby)(void)
      ARM: at91/pm_suspend: add the WFI instruction support for ARMv7
      ARM: at91/pm: flush data cache and clean, invalidate and disable the L2 cache

Yannick Guerrini (1):
      ARM: imx: Fix trivial typo in comments


 Documentation/arm/00-INDEX                      |    2 -
 Documentation/arm/msm/gpiomux.txt               |  176 ---
 .../devicetree/bindings/serial/atmel-usart.txt  |    3 +-
 MAINTAINERS                                     |   20 +-
 arch/arm/Kconfig                                |   16 +-
 arch/arm/Kconfig.debug                          |   31 +-
 arch/arm/Makefile                               |    2 -
 arch/arm/boot/dts/at91rm9200.dtsi               |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |    2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |    2 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |    2 +-
 arch/arm/configs/imx_v4_v5_defconfig            |    3 +-
 arch/arm/configs/msm_defconfig                  |  121 --
 arch/arm/configs/multi_v5_defconfig             |    2 +-
 arch/arm/include/debug/msm.S                    |   14 -
 arch/arm/mach-at91/Kconfig                      |   19 +-
 arch/arm/mach-at91/Makefile                     |    4 +-
 arch/arm/mach-at91/at91rm9200.c                 |   29 +-
 arch/arm/mach-at91/at91sam9.c                   |   76 +-
 arch/arm/mach-at91/generic.h                    |    4 -
 arch/arm/mach-at91/include/mach/at91_matrix.h   |   23 -
 .../mach-at91/include/mach/at91sam9260_matrix.h |   80 -
 .../mach-at91/include/mach/at91sam9261_matrix.h |   64 -
 .../mach-at91/include/mach/at91sam9263_matrix.h |  129 --
 .../mach-at91/include/mach/at91sam9g45_matrix.h |  153 --
 .../mach-at91/include/mach/at91sam9n12_matrix.h |   53 -
 .../mach-at91/include/mach/at91sam9rl_matrix.h  |   96 --
 .../mach-at91/include/mach/at91sam9x5_matrix.h  |   53 -
 arch/arm/mach-at91/include/mach/io.h            |   27 -
 arch/arm/mach-at91/pm.c                         |  139 +-
 arch/arm/mach-at91/pm.h                         |   14 +-
 arch/arm/mach-at91/pm_slowclock.S               |  335 ----
 arch/arm/mach-at91/pm_suspend.S                 |  338 ++++
 arch/arm/mach-at91/sama5.c                      |   97 +-
 arch/arm/mach-at91/setup.c                      |  330 ----
 arch/arm/mach-at91/soc.c                        |   97 ++
 arch/arm/mach-at91/soc.h                        |   78 +
 arch/arm/mach-davinci/asp.h                     |    7 +
 arch/arm/mach-davinci/devices-da8xx.c           |   80 +-
 arch/arm/mach-davinci/dm646x.c                  |   24 +-
 arch/arm/mach-davinci/include/mach/irqs.h       |    2 +-
 arch/arm/mach-imx/Kconfig                       |   81 +-
 arch/arm/mach-imx/Makefile                      |    8 +-
 arch/arm/mach-imx/clk-imx25.c                   |   75 -
 arch/arm/mach-imx/common.h                      |    5 -
 arch/arm/mach-imx/cpu-imx25.c                   |   11 +-
 arch/arm/mach-imx/devices-imx25.h               |   85 -
 arch/arm/mach-imx/devices/Kconfig               |    3 -
 arch/arm/mach-imx/devices/Makefile              |    1 -
 arch/arm/mach-imx/devices/platform-fec.c        |    5 -
 .../mach-imx/devices/platform-fsl-usb2-udc.c    |    5 -
 arch/arm/mach-imx/devices/platform-imx-fb.c     |    5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c    |   10 -
 arch/arm/mach-imx/devices/platform-imx-keypad.c |    5 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c    |    9 -
 arch/arm/mach-imx/devices/platform-imx-uart.c   |   12 -
 arch/arm/mach-imx/devices/platform-imx2-wdt.c   |    5 -
 arch/arm/mach-imx/devices/platform-imxdi_rtc.c  |   42 -
 arch/arm/mach-imx/devices/platform-mx2-camera.c |    5 -
 arch/arm/mach-imx/devices/platform-mxc-ehci.c   |    7 -
 arch/arm/mach-imx/devices/platform-mxc_nand.c   |    5 -
 arch/arm/mach-imx/devices/platform-spi_imx.c    |   11 -
 arch/arm/mach-imx/ehci-imx25.c                  |   99 --
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c  |  310 ----
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c  |    2 +-
 arch/arm/mach-imx/hardware.h                    |    1 -
 arch/arm/mach-imx/iomux-mx25.h                  |  524 -------
 arch/arm/mach-imx/iomux-mx3.h                   |    2 +-
 arch/arm/mach-imx/iomux-v3.c                    |    5 +-
 arch/arm/mach-imx/iomux-v3.h                    |    5 +-
 arch/arm/mach-imx/mach-cpuimx35.c               |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c        |  172 --
 arch/arm/mach-imx/{imx25-dt.c => mach-imx25.c}  |   20 +-
 arch/arm/mach-imx/mach-mx25_3ds.c               |  270 ----
 arch/arm/mach-imx/mach-mx35_3ds.c               |    2 +-
 arch/arm/mach-imx/mach-pcm043.c                 |    2 +-
 arch/arm/mach-imx/mach-vpr200.c                 |    2 +-
 arch/arm/mach-imx/mm-imx25.c                    |   89 --
 arch/arm/mach-imx/mx25.h                        |  117 --
 arch/arm/mach-msm/Kconfig                       |  109 --
 arch/arm/mach-msm/Makefile                      |   23 -
 arch/arm/mach-msm/Makefile.boot                 |    3 -
 arch/arm/mach-msm/board-halibut.c               |  110 --
 arch/arm/mach-msm/board-msm7x30.c               |  191 ---
 arch/arm/mach-msm/board-qsd8x50.c               |  254 ---
 arch/arm/mach-msm/board-sapphire.c              |  114 --
 arch/arm/mach-msm/board-trout-gpio.c            |  233 ---
 arch/arm/mach-msm/board-trout-mmc.c             |  185 ---
 arch/arm/mach-msm/board-trout-panel.c           |  292 ----
 arch/arm/mach-msm/board-trout.c                 |  111 --
 arch/arm/mach-msm/board-trout.h                 |  162 --
 arch/arm/mach-msm/clock-pcom.c                  |  176 ---
 arch/arm/mach-msm/clock-pcom.h                  |  145 --
 arch/arm/mach-msm/clock.c                       |   28 -
 arch/arm/mach-msm/clock.h                       |   43 -
 arch/arm/mach-msm/common.h                      |   41 -
 arch/arm/mach-msm/devices-msm7x00.c             |  480 ------
 arch/arm/mach-msm/devices-msm7x30.c             |  246 ---
 arch/arm/mach-msm/devices-qsd8x50.c             |  388 -----
 arch/arm/mach-msm/devices.h                     |   53 -
 arch/arm/mach-msm/dma.c                         |  298 ----
 arch/arm/mach-msm/gpiomux-8x50.c                |   51 -
 arch/arm/mach-msm/gpiomux-v1.h                  |   67 -
 arch/arm/mach-msm/gpiomux.c                     |  111 --
 arch/arm/mach-msm/gpiomux.h                     |   84 -
 arch/arm/mach-msm/include/mach/clk.h            |   31 -
 arch/arm/mach-msm/include/mach/dma.h            |  151 --
 arch/arm/mach-msm/include/mach/entry-macro.S    |   36 -
 arch/arm/mach-msm/include/mach/hardware.h       |   18 -
 arch/arm/mach-msm/include/mach/irqs-7x00.h      |   75 -
 arch/arm/mach-msm/include/mach/irqs-7x30.h      |  153 --
 arch/arm/mach-msm/include/mach/irqs-8x50.h      |   88 --
 arch/arm/mach-msm/include/mach/irqs.h           |   37 -
 arch/arm/mach-msm/include/mach/msm_gpiomux.h    |   38 -
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |  108 --
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |  103 --
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |  125 --
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   53 -
 arch/arm/mach-msm/include/mach/msm_smd.h        |  109 --
 arch/arm/mach-msm/include/mach/sirc.h           |   98 --
 arch/arm/mach-msm/include/mach/vreg.h           |   29 -
 arch/arm/mach-msm/io.c                          |  161 --
 arch/arm/mach-msm/irq-vic.c                     |  363 -----
 arch/arm/mach-msm/irq.c                         |  151 --
 arch/arm/mach-msm/last_radio_log.c              |   71 -
 arch/arm/mach-msm/proc_comm.c                   |  129 --
 arch/arm/mach-msm/proc_comm.h                   |  258 ---
 arch/arm/mach-msm/sirc.c                        |  172 --
 arch/arm/mach-msm/smd.c                         | 1034 ------------
 arch/arm/mach-msm/smd_debug.c                   |  311 ----
 arch/arm/mach-msm/smd_private.h                 |  403 -----
 arch/arm/mach-msm/vreg.c                        |  220 ---
 arch/arm/mach-mvebu/board-v7.c                  |    6 +-
 arch/arm/mach-mvebu/dove.c                      |    2 +-
 arch/arm/mach-mvebu/kirkwood.c                  |    2 +-
 arch/arm/mach-omap2/Kconfig                     |   18 -
 arch/arm/mach-omap2/Makefile                    |    4 -
 arch/arm/mach-omap2/board-devkit8000.c          |  654 --------
 arch/arm/mach-omap2/board-omap3stalker.c        |  433 -----
 arch/arm/mach-omap2/board-omap3touchbook.c      |  395 -----
 arch/arm/mach-shmobile/Makefile                 |    6 +-
 arch/arm/mach-shmobile/common.h                 |    9 -
 arch/arm/mach-shmobile/cpuidle.c                |   37 -
 arch/arm/mach-shmobile/pm-r8a7790.c             |   82 -
 arch/arm/mach-shmobile/pm-r8a7791.c             |   73 -
 arch/arm/mach-shmobile/pm-rcar-gen2.c           |  115 ++
 arch/arm/mach-shmobile/pm-sh7372.c              |    2 +-
 arch/arm/mach-shmobile/r8a7790.h                |    1 -
 arch/arm/mach-shmobile/r8a7791.h                |    1 -
 arch/arm/mach-shmobile/rcar-gen2.h              |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c          |    8 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |    4 -
 arch/arm/mach-shmobile/smp-r8a7790.c            |    3 +-
 arch/arm/mach-shmobile/smp-r8a7791.c            |    2 +-
 drivers/gpio/Kconfig                            |    8 -
 drivers/gpio/Makefile                           |    1 -
 drivers/gpio/gpio-msm-v1.c                      |  714 ---------
 drivers/mmc/host/Kconfig                        |    8 -
 drivers/mmc/host/Makefile                       |    1 -
 drivers/mmc/host/msm_sdcc.c                     | 1474 ------------------
 drivers/mmc/host/msm_sdcc.h                     |  256 ---
 drivers/pcmcia/Kconfig                          |    1 +
 drivers/pcmcia/at91_cf.c                        |   13 +-
 include/linux/platform_data/mmc-msm_sdcc.h      |   27 -
 170 files changed, 1011 insertions(+), 16653 deletions(-)
 delete mode 100644 Documentation/arm/msm/gpiomux.txt
 delete mode 100644 arch/arm/configs/msm_defconfig
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9260_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9261_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9263_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9g45_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9rl_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h
 delete mode 100644 arch/arm/mach-at91/pm_slowclock.S
 create mode 100644 arch/arm/mach-at91/pm_suspend.S
 delete mode 100644 arch/arm/mach-at91/setup.c
 create mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 arch/arm/mach-at91/soc.h
 delete mode 100644 arch/arm/mach-imx/devices-imx25.h
 delete mode 100644 arch/arm/mach-imx/devices/platform-imxdi_rtc.c
 delete mode 100644 arch/arm/mach-imx/ehci-imx25.c
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
 delete mode 100644 arch/arm/mach-imx/iomux-mx25.h
 delete mode 100644 arch/arm/mach-imx/mach-eukrea_cpuimx25.c
 rename arch/arm/mach-imx/{imx25-dt.c => mach-imx25.c} (68%)
 delete mode 100644 arch/arm/mach-imx/mach-mx25_3ds.c
 delete mode 100644 arch/arm/mach-imx/mm-imx25.c
 delete mode 100644 arch/arm/mach-imx/mx25.h
 delete mode 100644 arch/arm/mach-msm/Kconfig
 delete mode 100644 arch/arm/mach-msm/Makefile
 delete mode 100644 arch/arm/mach-msm/Makefile.boot
 delete mode 100644 arch/arm/mach-msm/board-halibut.c
 delete mode 100644 arch/arm/mach-msm/board-msm7x30.c
 delete mode 100644 arch/arm/mach-msm/board-qsd8x50.c
 delete mode 100644 arch/arm/mach-msm/board-sapphire.c
 delete mode 100644 arch/arm/mach-msm/board-trout-gpio.c
 delete mode 100644 arch/arm/mach-msm/board-trout-mmc.c
 delete mode 100644 arch/arm/mach-msm/board-trout-panel.c
 delete mode 100644 arch/arm/mach-msm/board-trout.c
 delete mode 100644 arch/arm/mach-msm/board-trout.h
 delete mode 100644 arch/arm/mach-msm/clock-pcom.c
 delete mode 100644 arch/arm/mach-msm/clock-pcom.h
 delete mode 100644 arch/arm/mach-msm/clock.c
 delete mode 100644 arch/arm/mach-msm/clock.h
 delete mode 100644 arch/arm/mach-msm/common.h
 delete mode 100644 arch/arm/mach-msm/devices-msm7x00.c
 delete mode 100644 arch/arm/mach-msm/devices-msm7x30.c
 delete mode 100644 arch/arm/mach-msm/devices-qsd8x50.c
 delete mode 100644 arch/arm/mach-msm/devices.h
 delete mode 100644 arch/arm/mach-msm/dma.c
 delete mode 100644 arch/arm/mach-msm/gpiomux-8x50.c
 delete mode 100644 arch/arm/mach-msm/gpiomux-v1.h
 delete mode 100644 arch/arm/mach-msm/gpiomux.c
 delete mode 100644 arch/arm/mach-msm/gpiomux.h
 delete mode 100644 arch/arm/mach-msm/include/mach/clk.h
 delete mode 100644 arch/arm/mach-msm/include/mach/dma.h
 delete mode 100644 arch/arm/mach-msm/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-msm/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs-7x00.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs-7x30.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs-8x50.h
 delete mode 100644 arch/arm/mach-msm/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_gpiomux.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_iomap.h
 delete mode 100644 arch/arm/mach-msm/include/mach/msm_smd.h
 delete mode 100644 arch/arm/mach-msm/include/mach/sirc.h
 delete mode 100644 arch/arm/mach-msm/include/mach/vreg.h
 delete mode 100644 arch/arm/mach-msm/io.c
 delete mode 100644 arch/arm/mach-msm/irq-vic.c
 delete mode 100644 arch/arm/mach-msm/irq.c
 delete mode 100644 arch/arm/mach-msm/last_radio_log.c
 delete mode 100644 arch/arm/mach-msm/proc_comm.c
 delete mode 100644 arch/arm/mach-msm/proc_comm.h
 delete mode 100644 arch/arm/mach-msm/sirc.c
 delete mode 100644 arch/arm/mach-msm/smd.c
 delete mode 100644 arch/arm/mach-msm/smd_debug.c
 delete mode 100644 arch/arm/mach-msm/smd_private.h
 delete mode 100644 arch/arm/mach-msm/vreg.c
 delete mode 100644 arch/arm/mach-omap2/board-devkit8000.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3stalker.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
 delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7791.c
 create mode 100644 arch/arm/mach-shmobile/pm-rcar-gen2.c
 delete mode 100644 drivers/gpio/gpio-msm-v1.c
 delete mode 100644 drivers/mmc/host/msm_sdcc.c
 delete mode 100644 drivers/mmc/host/msm_sdcc.h
 delete mode 100644 include/linux/platform_data/mmc-msm_sdcc.h
