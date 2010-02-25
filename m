From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Feb 2010 15:09:22 +0100
Subject: MXC Pull request
Message-ID: <20100225140922.GE25271@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Here are the mxc related patches for this merge window. Please pull.

Sascha


The following changes since commit e9e70bc14ea5974e21f5baecf95a123844c412b9:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.monstr.eu/linux-2.6-microblaze

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Amit Kucheria (6):
      mxc: TrustZone interrupt controller (TZIC) for Freescale i.MX5 family
      mxc: changes to common plat-mxc code to add support for i.MX5
      mxc: Core support for Freescale i.MX5 series
      mxc: Add support for the Babbage board (i.MX5)
      mxc: Add mx51_defconfig
      mxc: MAINTAINERS: Add maintainer for mach-mx5

Andy Green (1):
      imx-serial-excessive-status-clearing-on-break.patch

Baruch Siach (13):
      mtd: mxc_nand: add MX25 to Kconfig
      mx25: add NAND support
      mx25pdk: add NAND device support
      mx25: remove unused mx25_clocks_init() argument
      mx25: properly initialize clocks
      mx25: fix time accounting
      mx25: make the FEC AHB clk secondary of the IPG
      mx25: add support for the DryIce rtc
      mx25pdk: platform code for the DryIce RTC module
      imxfb: add support for i.MX25
      mx25: add platform support for imxfb
      mx25pdk: add LCD support
      mx25: move ARCH_MXC_IOMUX_V3 to the ARCH level

Fabio Estevam (1):
      mx51_babbage: Fix ckih2 parameter in mx51_clocks_init function

Mark Brown (7):
      mx31ads: Convert 1133-EV1 to use dev_name to specify consumer devices
      mx31ads: Allow enable/disable of switchable supplies
      mx31ads: Allow enable/disable of switchable supplies
      mx31ads: Provide a name for EXPIO interrupt chip
      mx31ads: Provide an IRQ range to the WM835x on the 1133-EV1 module
      MXC: Add AUDMUXv2 register decode to debugfs
      mx31ads: Configure SSI5 pins in IOMUX for PMIC module audio support

Roel Kluin (1):
      MX1/MX2: -EINVAL overwritten in second iteration in mxc_gpio_setup_multiple_pins()

Sascha Hauer (18):
      Merge branch 'imx' of git://git.pengutronix.de/git/ukl/linux-2.6 into mxc-master
      i.MX25: Allow secondary clocks in DEFINE_CLOCK
      i.MX25: implement secondary clocks for uarts and fec
      Merge branch 'mxc-rc' into mxc-master
      Merge branch 'imx/master' of git://git.pengutronix.de/git/ukl/linux-2.6 into mxc-master
      fsl_mx3_udc: Add i.MX35 support
      i.MX ehci platform support: Some fixes
      i.MX27: Add USB control register access support
      i.MX35: Add USB control register access support
      i.MX27 pca100: Add USB support
      i.MX27 pcm038: Add USB support
      i.MX31 pcm037: Add USB support
      i.MX27 pca100: Add USB support
      mxc: refactor timer code to use timer versions
      add ssi header file
      pca100: add sound support
      i.MX pcm043: Add AC97 sound support
      Merge branch 'mx51-baseport-sascha' of git://kernel.ubuntu.com/amitk/mx51-upstream into mxc-master

Uwe Kleine-K?nig (75):
      imx/mx2: fold crm_regs.h into its only consumer
      imx/clock-imx21: use a macro to define registers
      imx/clock-imx27: use a macro to define registers
      imx/mach-mx2: use constants namespaced by the corresponding SOC (easy part)
      imx/mach-mx3: use constants namespaced by the corresponding SOC (easy part)
      imx/mx3: rename clock.c and iomux.c to {clock,iomux}-imx31.c
      imx/mx1: add newline at end of Makefile
      imx/mx1: rename files defining a machine to mach-$mach.c
      imx: rename Kconfig symbol for "Eukrea CPUIMX27 module"
      imx: rename Kconfig symbol for "LogicPD MX27 LITEKIT platform"
      imx/mx2: rename files defining a machine to mach-$mach.c
      imx/mx3: rename files defining a machine to mach-$mach.c
      imx: provide helper macro to define IO_ADDRESS
      imx21: define and use MX21_IO_ADDRESS
      imx27: define and use MX27_IO_ADDRESS
      imx31: define and use MX31_IO_ADDRESS
      imx25: redefine MX25_IO_ADDRESS using IMX_IO_ADDRESS
      imx35: define and use MX35_IO_ADDRESS
      mx3/kzm_arm11_01: define and use board specific IO_ADDRESS macro
      imx: mangle addresses after adding the offset
      imx: only define deprecated symbols conditionally
      imx: remove mx1ads defconfig
      imx: remove unneeded include of mach/hardware.h
      imx: properly protect mach/mx{1,[25][157x]}.h from multiple inclusion
      imx: define functions to configure chip selects in the WEIM
      mx2/mx3: debug-macro.S needs deprecated symbols
      mx35: add a missing comma in a pad definition
      mx1: prefix SOC specific defines with MX1_ and deprecate old names
      mx25: deprecate UART1_BASE_ADDR and UART2_BASE_ADDR
      imx: WARN in clk_disable if the clock isn't enabled
      mxc91231: use MXC91231_IO_ADDRESS instead of MXC91231_AIPS1_IO_ADDRESS
      mxc91231: redefine MXC91231_IO_ADDRESS using IMX_IO_ADDRESS
      imx2x: convert serial.c to use soc-prefixed constants
      imx: define per SOC ..._PHYS_OFFSET and use these in favour of PHYS_OFFSET
      imx/mx25: rename files defining a machine to mach-$mach.c
      arm/mx2: use cpp magic to create spi_imx devices
      arm/mx2: use cpp magic to create imx_gpt devices
      arm/mx2: use cpp magic to create imx-i2c devices
      arm/mx2: use cpp magic to create imx-mmc devices
      arm/mx2: use cpp magic to create imx-ssi devices
      arm/mx2/devices: use SoC-prefixed names where possible
      arm/mx2: define seperate imx_nand devices for imx21 and imx27
      arm/mx2: use per-SOC nand device
      arm/mx2: define seperate gpio port descriptions for imx21 and imx27
      arm/mx2/devices: no need for IMX_NEEDS_DEPRECATED_SYMBOLS any more
      arm/mx2: split generic.c into mm-imx2[17].c
      arm/imx/gpio: GPIO_INT_{HIGH,LOW}_LEV are not necessarily constant
      arm/imx: use generic_handle_irq instead of open-coding it
      arm/imx/gpio: use fls to find set bits in the irq status register
      arm/imx/gpio: remove a BUG_ON in hot path
      arm/imx/audmux-v1: use SoC-prefixed names
      arm/imx/audmux-v2: use SoC-prefixed names
      arm/imx: remove "NO_PAD_CTRL" from Copyright statements
      arm/imx: let ARCH_MXC select COMMON_CLKDEV instead of each subfamily
      arm/imx: don't explicitly select GENERIC_GPIO
      arm/imx: remove MTD_XIP support
      arm/imx: remove #ifndef CONFIG_COMMON_CLKDEV block
      arm/imx: don't depend on ARCH_MXC twice
      arm/imx/irq: order definitions of MXC_GPIO_IRQS numerically
      arm/imx: choose sane CONSISTENT_DMA_SIZE if video is enabled for both mx1 and mx3
      arm/imx/dma-v1: don't use deprecated symbols DMA_BASE and MXC_INT_DMACH0
      arm/imx/dma-v1: protect #ifdef'd blocks additionally by cpu_is_...
      arm/imx/iomux-v1: rename source file and reorganize Kconfig stuff
      arm/imx/iomux-v1: make base address a runtime choice
      arm/imx/iomux-mx1: unify style and comment cleanup
      arm/imx/iomux-mx21: unify style
      arm/imx/iomux-mx25: unify style and comment cleanup
      arm/imx/iomux-mx27: unify style and comments
      arm/imx/iomux-mx2x: unify style
      arm/imx/iomux-mx3.h: unify style and comments
      arm/mx25: don't include iomux.h which is for iomux-v1 machines
      arm/imx/iomux-v1: rename header file
      arm/imx: let platform files include the SoC-specific iomux header
      arm/imx/iomux-v1: check for invalid modes in mxc_gpio_mode
      Merge branch 'mxc-master' of git://git.pengutronix.de/git/imx/linux-2.6 into imx/master

Valentin Longchamp (3):
      mx31moboard: change initial reset status for robot microcontollers
      mx31moboard: make usbh2 enable gpio claim more atomic
      mx31moboard: support for the smartbot baseboard

Vladimir Zapolskiy (2):
      ARM: MX3: Fixed typo in declared enum type name.
      ARM: IMX31: configure pins iomux for SDHC setup on litekit board.

 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    3 +-
 arch/arm/Makefile                                  |    1 +
 arch/arm/configs/mx1ads_defconfig                  |  742 -----------
 arch/arm/configs/mx27_defconfig                    |    2 +-
 arch/arm/configs/mx51_defconfig                    | 1286 ++++++++++++++++++++
 arch/arm/mach-mx1/Makefile                         |    5 +-
 arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c}      |    8 +-
 arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c}    |    4 +-
 arch/arm/mach-mx2/Kconfig                          |   10 +-
 arch/arm/mach-mx2/Makefile                         |   23 +-
 arch/arm/mach-mx2/clock_imx21.c                    |  236 ++++-
 arch/arm/mach-mx2/clock_imx27.c                    |   33 +-
 arch/arm/mach-mx2/cpu_imx27.c                      |    3 +-
 arch/arm/mach-mx2/crm_regs.h                       |  258 ----
 arch/arm/mach-mx2/devices.c                        |  643 ++++------
 arch/arm/mach-mx2/devices.h                        |   13 +-
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c       |    2 +-
 .../{eukrea_cpuimx27.c => mach-cpuimx27.c}         |   19 +-
 arch/arm/mach-mx2/{mx27lite.c => mach-imx27lite.c} |    8 +-
 arch/arm/mach-mx2/{mx21ads.c => mach-mx21ads.c}    |   16 +-
 arch/arm/mach-mx2/{mx27pdk.c => mach-mx27_3ds.c}   |    8 +-
 arch/arm/mach-mx2/{mx27ads.c => mach-mx27ads.c}    |   12 +-
 arch/arm/mach-mx2/{mxt_td60.c => mach-mxt_td60.c}  |   10 +-
 arch/arm/mach-mx2/mach-pca100.c                    |  395 ++++++
 arch/arm/mach-mx2/{pcm038.c => mach-pcm038.c}      |   40 +-
 arch/arm/mach-mx2/{generic.c => mm-imx21.c}        |   46 +-
 arch/arm/mach-mx2/{generic.c => mm-imx27.c}        |   44 +-
 arch/arm/mach-mx2/pca100.c                         |  244 ----
 arch/arm/mach-mx2/pcm970-baseboard.c               |    6 +-
 arch/arm/mach-mx2/serial.c                         |   48 +-
 arch/arm/mach-mx25/Kconfig                         |    1 -
 arch/arm/mach-mx25/Makefile                        |    2 +-
 arch/arm/mach-mx25/clock.c                         |   72 +-
 arch/arm/mach-mx25/devices.c                       |   62 +
 arch/arm/mach-mx25/devices.h                       |    3 +
 arch/arm/mach-mx25/{mx25pdk.c => mach-mx25pdk.c}   |   69 +-
 arch/arm/mach-mx3/Kconfig                          |    2 +
 arch/arm/mach-mx3/Makefile                         |   32 +-
 arch/arm/mach-mx3/{clock.c => clock-imx31.c}       |    5 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    5 +-
 arch/arm/mach-mx3/cpu.c                            |    2 +-
 arch/arm/mach-mx3/crm_regs.h                       |    2 +-
 arch/arm/mach-mx3/{iomux.c => iomux-imx31.c}       |    2 +-
 .../{armadillo5x0.c => mach-armadillo5x0.c}        |   14 +-
 .../mach-mx3/{kzmarm11.c => mach-kzm_arm11_01.c}   |   33 +-
 arch/arm/mach-mx3/{mx31pdk.c => mach-mx31_3ds.c}   |   12 +-
 arch/arm/mach-mx3/{mx31ads.c => mach-mx31ads.c}    |   48 +-
 .../arm/mach-mx3/{mx31lilly.c => mach-mx31lilly.c} |   10 +-
 arch/arm/mach-mx3/{mx31lite.c => mach-mx31lite.c}  |   16 +-
 .../mach-mx3/{mx31moboard.c => mach-mx31moboard.c} |   49 +-
 arch/arm/mach-mx3/{mx35pdk.c => mach-mx35pdk.c}    |    6 +-
 arch/arm/mach-mx3/{pcm037.c => mach-pcm037.c}      |  155 ++-
 .../mach-mx3/{pcm037_eet.c => mach-pcm037_eet.c}   |    0
 arch/arm/mach-mx3/mach-pcm043.c                    |  413 +++++++
 arch/arm/mach-mx3/{qong.c => mach-qong.c}          |   20 +-
 arch/arm/mach-mx3/mx31lite-db.c                    |   30 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c           |   32 +
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |   39 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |  162 +++
 arch/arm/mach-mx3/pcm043.c                         |  259 ----
 arch/arm/mach-mx5/Kconfig                          |   18 +
 arch/arm/mach-mx5/Makefile                         |    9 +
 arch/arm/mach-mx5/Makefile.boot                    |    3 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |   98 ++
 arch/arm/mach-mx5/clock-mx51.c                     |  825 +++++++++++++
 arch/arm/mach-mx5/cpu.c                            |   47 +
 arch/arm/mach-mx5/crm_regs.h                       |  583 +++++++++
 arch/arm/mach-mx5/devices.c                        |   96 ++
 arch/arm/mach-mx5/devices.h                        |    4 +
 arch/arm/mach-mx5/mm.c                             |   89 ++
 arch/arm/mach-mxc91231/magx-zn5.c                  |    2 +-
 arch/arm/plat-mxc/Kconfig                          |   30 +-
 arch/arm/plat-mxc/Makefile                         |    8 +-
 arch/arm/plat-mxc/audmux-v1.c                      |   14 +-
 arch/arm/plat-mxc/audmux-v2.c                      |  144 +++-
 arch/arm/plat-mxc/clock.c                          |    1 +
 arch/arm/plat-mxc/dma-mx1-mx2.c                    |  207 ++--
 arch/arm/plat-mxc/ehci.c                           |  122 ++-
 arch/arm/plat-mxc/gpio.c                           |   30 +-
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h    |   18 +-
 arch/arm/plat-mxc/include/mach/board-mx31ads.h     |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31lite.h    |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    2 +
 arch/arm/plat-mxc/include/mach/clock.h             |    7 -
 arch/arm/plat-mxc/include/mach/common.h            |    7 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |   12 +-
 arch/arm/plat-mxc/include/mach/entry-macro.S       |   34 +-
 arch/arm/plat-mxc/include/mach/hardware.h          |    9 +
 arch/arm/plat-mxc/include/mach/iomux-mx1.h         |  313 +++---
 arch/arm/plat-mxc/include/mach/iomux-mx21.h        |  210 ++--
 arch/arm/plat-mxc/include/mach/iomux-mx25.h        |   24 +-
 arch/arm/plat-mxc/include/mach/iomux-mx27.h        |  372 +++---
 arch/arm/plat-mxc/include/mach/iomux-mx2x.h        |  425 ++++----
 arch/arm/plat-mxc/include/mach/iomux-mx3.h         |   76 +-
 arch/arm/plat-mxc/include/mach/iomux-mx35.h        |    4 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |  326 +++++
 arch/arm/plat-mxc/include/mach/iomux-v1.h          |  103 ++
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |    8 +-
 arch/arm/plat-mxc/include/mach/iomux.h             |  128 +--
 arch/arm/plat-mxc/include/mach/irqs.h              |   25 +-
 arch/arm/plat-mxc/include/mach/memory.h            |   54 +-
 arch/arm/plat-mxc/include/mach/mtd-xip.h           |   34 -
 arch/arm/plat-mxc/include/mach/mx1.h               |  395 ++++--
 arch/arm/plat-mxc/include/mach/mx21.h              |   13 +-
 arch/arm/plat-mxc/include/mach/mx25.h              |   36 +-
 arch/arm/plat-mxc/include/mach/mx27.h              |   32 +-
 arch/arm/plat-mxc/include/mach/mx2x.h              |    8 +-
 arch/arm/plat-mxc/include/mach/mx31.h              |   33 +
 arch/arm/plat-mxc/include/mach/mx35.h              |   13 +
 arch/arm/plat-mxc/include/mach/mx3x.h              |    8 +-
 arch/arm/plat-mxc/include/mach/mx51.h              |  454 +++++++
 arch/arm/plat-mxc/include/mach/mxc.h               |   20 +-
 arch/arm/plat-mxc/include/mach/mxc91231.h          |   58 +-
 arch/arm/plat-mxc/include/mach/mxc_ehci.h          |    4 +
 arch/arm/plat-mxc/include/mach/ssi.h               |   18 +
 arch/arm/plat-mxc/include/mach/timex.h             |    2 +
 arch/arm/plat-mxc/include/mach/uncompress.h        |    3 -
 arch/arm/plat-mxc/iomux-mx1-mx2.c                  |  157 ---
 arch/arm/plat-mxc/iomux-v1.c                       |  238 ++++
 arch/arm/plat-mxc/time.c                           |   41 +-
 arch/arm/plat-mxc/tzic.c                           |  172 +++
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/serial/imx.c                               |    2 +-
 drivers/usb/gadget/fsl_mx3_udc.c                   |   31 +-
 drivers/video/Kconfig                              |    5 +-
 126 files changed, 8217 insertions(+), 3784 deletions(-)
 delete mode 100644 arch/arm/configs/mx1ads_defconfig
 create mode 100644 arch/arm/configs/mx51_defconfig
 rename arch/arm/mach-mx1/{mx1ads.c => mach-mx1ads.c} (95%)
 rename arch/arm/mach-mx1/{scb9328.c => mach-scb9328.c} (98%)
 delete mode 100644 arch/arm/mach-mx2/crm_regs.h
 rename arch/arm/mach-mx2/{eukrea_cpuimx27.c => mach-cpuimx27.c} (91%)
 rename arch/arm/mach-mx2/{mx27lite.c => mach-imx27lite.c} (93%)
 rename arch/arm/mach-mx2/{mx21ads.c => mach-mx21ads.c} (94%)
 rename arch/arm/mach-mx2/{mx27pdk.c => mach-mx27_3ds.c} (93%)
 rename arch/arm/mach-mx2/{mx27ads.c => mach-mx27ads.c} (96%)
 rename arch/arm/mach-mx2/{mxt_td60.c => mach-mxt_td60.c} (96%)
 create mode 100644 arch/arm/mach-mx2/mach-pca100.c
 rename arch/arm/mach-mx2/{pcm038.c => mach-pcm038.c} (89%)
 copy arch/arm/mach-mx2/{generic.c => mm-imx21.c} (66%)
 rename arch/arm/mach-mx2/{generic.c => mm-imx27.c} (67%)
 delete mode 100644 arch/arm/mach-mx2/pca100.c
 rename arch/arm/mach-mx25/{mx25pdk.c => mach-mx25pdk.c} (68%)
 rename arch/arm/mach-mx3/{clock.c => clock-imx31.c} (99%)
 rename arch/arm/mach-mx3/{iomux.c => iomux-imx31.c} (98%)
 rename arch/arm/mach-mx3/{armadillo5x0.c => mach-armadillo5x0.c} (97%)
 rename arch/arm/mach-mx3/{kzmarm11.c => mach-kzm_arm11_01.c} (89%)
 rename arch/arm/mach-mx3/{mx31pdk.c => mach-mx31_3ds.c} (96%)
 rename arch/arm/mach-mx3/{mx31ads.c => mach-mx31ads.c} (93%)
 rename arch/arm/mach-mx3/{mx31lilly.c => mach-mx31lilly.c} (96%)
 rename arch/arm/mach-mx3/{mx31lite.c => mach-mx31lite.c} (95%)
 rename arch/arm/mach-mx3/{mx31moboard.c => mach-mx31moboard.c} (93%)
 rename arch/arm/mach-mx3/{mx35pdk.c => mach-mx35pdk.c} (95%)
 rename arch/arm/mach-mx3/{pcm037.c => mach-pcm037.c} (82%)
 rename arch/arm/mach-mx3/{pcm037_eet.c => mach-pcm037_eet.c} (100%)
 create mode 100644 arch/arm/mach-mx3/mach-pcm043.c
 rename arch/arm/mach-mx3/{qong.c => mach-qong.c} (93%)
 create mode 100644 arch/arm/mach-mx3/mx31moboard-smartbot.c
 delete mode 100644 arch/arm/mach-mx3/pcm043.c
 create mode 100644 arch/arm/mach-mx5/Kconfig
 create mode 100644 arch/arm/mach-mx5/Makefile
 create mode 100644 arch/arm/mach-mx5/Makefile.boot
 create mode 100644 arch/arm/mach-mx5/board-mx51_babbage.c
 create mode 100644 arch/arm/mach-mx5/clock-mx51.c
 create mode 100644 arch/arm/mach-mx5/cpu.c
 create mode 100644 arch/arm/mach-mx5/crm_regs.h
 create mode 100644 arch/arm/mach-mx5/devices.c
 create mode 100644 arch/arm/mach-mx5/devices.h
 create mode 100644 arch/arm/mach-mx5/mm.c
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx51.h
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-v1.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/mtd-xip.h
 create mode 100644 arch/arm/plat-mxc/include/mach/mx51.h
 create mode 100644 arch/arm/plat-mxc/include/mach/ssi.h
 delete mode 100644 arch/arm/plat-mxc/iomux-mx1-mx2.c
 create mode 100644 arch/arm/plat-mxc/iomux-v1.c
 create mode 100644 arch/arm/plat-mxc/tzic.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
