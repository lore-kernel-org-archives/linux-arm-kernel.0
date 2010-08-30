From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:31 +0530
Subject: [PATCH 00/74] Updating SPEAr Support
Message-ID: <cover.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following set of patches:
- updates SPEAr3xx, 6xx support
- Adds support for SPEAr13xx
- Removes Multiple defconfigs per machine family

Bhupesh Sharma (2):
  ST SPEAr 13xx : Adding support for SPEAr1310
  ST SPEAr : Adding CAN platform support for SPEAr320 and SPEAr1310

Deepak Sikri (7):
  ST SPEAr: Adding USB Host support
  SPEAr Clock Framework: Adding support for PLL frequency change
  SPEAr Power Management: Added the support for Standby mode.
  GIC: Added dummy handlers for Power Management Suspend Resume
  SPEAr CPU freq: Adding support for CPU Freq framework
  ST SPEAr13xx: Adding CPU hotplug support added for SMP platforms
  SPEAr13xx: Adding and Updating Clock definitions

Pratyush Anand (2):
  ST SPEAr: Added PCIE host controller base driver support.
  ST SPEAr: PCIE gadget suppport

Rajeev Kumar (3):
  ST SPEAr: adding support for rtc
  ST SPEAr: adding support for synopsis i2c designware
  ST SPEAr : Added keyboard support

Ryan Mallon (5):
  SPEAr3xx: Make local structres static
  SPEAR3xx: Rename register/irq defines to remove naming conflicts
  SPEAr3xx: Rework pmx_dev code to remove conflicts
  SPEAr3xx: Rework KConfig to allow all boards to be compiled in
  SPEAr3xx: Replace defconfigs with single unfied defconfig

Shiraz Hashim (16):
  ST SPEAr: Formalized timer support
  ST SPEAr13XX: Adding machine specific header files
  ST SPEAr13XX: Adding machine specific src files
  ST SPEAr: Adding support for SPEAr13xx SoC in spear generic plat/
  ST SPEAr13XX: Added compilation support in arch/arm/
  ST SPEAr1300: Adding default config file
  ST SPEAr: Adding information in Documentation/ and MAINTAINERS
  ST SPEAr: Update clock framework and definitions
  ST SPEAr: enhanced spear clock framework
  ST SPEAr: Adding Debugfs support on clock framework
  ST SPEAr: Add smi driver for serial NOR flash
  ST SPEAr: Adding support for serial nor flash in all spear platforms
  ST SPEAr: Replacing SIZE macro's with actual required size
  SPEAr: removing size based macros except those necessary
  ST SPEAr13xx: add l2 cache support
  ST SPEAr13xx: Modified static mappings

Vipin Kumar (10):
  ST SPEAr : NAND interface driver for spear platforms
  Incrementing the ecc_pos array to contain 128 char
  Newly erased page read workaround
  ST SPEAr : EMI (Extrenal Memory Interface) controller driver
  ST SPEAr : FSMC (Flexible Static Memory Controller) NOR interface
    driver
  SPEAr : SEV Send event to secondary CPUs
  ST SPEAr1310: Adding fsmc nor support
  SPEAr : Pad multiplexing handling modified
  SPEAr13xx : Fixed part devices in SPEAr13xx addded to the generic
    implementation
  SPEAr : Adding SPEAr1310 pad multiplexing devices

Vipul-kumar Samar (1):
  ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx

Viresh Kumar (28):
  ST SPEAr: Padmux code Updated
  ST SPEAr: Making clock functions more generic
  ST SPEAr: Adding support for divisor per parent clock
  ST SPEAr: Correcting SOC Config base address for spear320
  ST SPEAr: Adding PLGPIO driver for spear platform
  Clock Framework: Adding ENABLED_ON_INIT feature in clk
  ST SPEAr: Added ARM PL061 GPIO Support on SPEAr13xx and modified
    resource size
  ST SPEAr: Adding support for ST's PWM IP
  ST SPEAr: Adding Watchdog support
  ST SPEAr: Adding support for SSP PL022
  ST SPEAr: Adding clk_set_rate support
  ST SPEAr: Adding support for SDHCI (SDIO)
  ST SPEAr: Changing resource size of amba devices to SZ_4K
  ST SPEAr: Enabling clocks before amba device registeration
  ST SPEAr3xx: Rearranging declarations in clock.c file
  ST SPEAr: Adding miscellaneous devices and clocks
  ST SPEAr: Adding support for DDR in clock framework
  ST SPEAr: SDHCI- selecting SD_MMC from misc and fixing sdhci_synth
    rate to 48 MHz
  ST SPEAr3xx: Passing pmx devices address from machine *.c files
  ST SPEAr: Appending spear3** with global structures
  ST SPEAr3xx: Updating plgpio and emi source to make it compliant with
    single image strategy
  SPEAr6xx: Rework Kconfig for single image solution
  ST SPEAR6xx: renaming spear600_defconfig as spear6xx_defconfig
  SPEAr13XX: Update register/macros/devices/routine names and pmx dev
    registration to implement single image for multiple boards.
  SPEAr13xx: Rework KConfig to allow all boards to be compiled in
  SPEAr13xx: Replace defconfigs with single unfied defconfig
  ST SPEAr: Updating defconfigs
  ST SPEAr: Enabling devices in various evb.c files

 Documentation/arm/SPEAr/overview.txt               |   33 +-
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |   19 +-
 arch/arm/Makefile                                  |    2 +
 arch/arm/common/gic.c                              |   13 +
 arch/arm/configs/spear13xx_defconfig               | 1769 ++++++++++++++++++++
 arch/arm/configs/spear300_defconfig                |   51 -
 arch/arm/configs/spear310_defconfig                |   52 -
 arch/arm/configs/spear320_defconfig                |   52 -
 arch/arm/configs/spear3xx_defconfig                | 1615 ++++++++++++++++++
 arch/arm/configs/spear600_defconfig                |   49 -
 arch/arm/configs/spear6xx_defconfig                | 1606 ++++++++++++++++++
 arch/arm/mach-spear13xx/Kconfig                    |   32 +
 arch/arm/mach-spear13xx/Makefile                   |   21 +
 arch/arm/mach-spear13xx/Makefile.boot              |    3 +
 arch/arm/mach-spear13xx/clock.c                    | 1140 +++++++++++++
 arch/arm/mach-spear13xx/fsmc-nor.c                 |   81 +
 arch/arm/mach-spear13xx/headsmp.S                  |   95 ++
 arch/arm/mach-spear13xx/hotplug.c                  |  146 ++
 arch/arm/mach-spear13xx/include/mach/clkdev.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear13xx/include/mach/entry-macro.S |   88 +
 arch/arm/mach-spear13xx/include/mach/generic.h     |  275 +++
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   37 +
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   37 +
 arch/arm/mach-spear13xx/include/mach/io.h          |   19 +
 arch/arm/mach-spear13xx/include/mach/irqs.h        |  152 ++
 arch/arm/mach-spear13xx/include/mach/memory.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/misc_regs.h   |  386 +++++
 arch/arm/mach-spear13xx/include/mach/pcie.h        |  169 ++
 arch/arm/mach-spear13xx/include/mach/smp.h         |   39 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |   95 ++
 arch/arm/mach-spear13xx/include/mach/spear1300.h   |   21 +
 arch/arm/mach-spear13xx/include/mach/spear1310.h   |   46 +
 arch/arm/mach-spear13xx/include/mach/suspend.h     |   47 +
 arch/arm/mach-spear13xx/include/mach/system.h      |   43 +
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear13xx/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-spear13xx/localtimer.c               |   25 +
 arch/arm/mach-spear13xx/pcie.c                     |  881 ++++++++++
 arch/arm/mach-spear13xx/platsmp.c                  |  220 +++
 arch/arm/mach-spear13xx/pm.c                       |  107 ++
 arch/arm/mach-spear13xx/sleep.S                    |  435 +++++
 arch/arm/mach-spear13xx/spear1300.c                |   38 +
 arch/arm/mach-spear13xx/spear1300_evb.c            |  212 +++
 arch/arm/mach-spear13xx/spear1310.c                |  468 ++++++
 arch/arm/mach-spear13xx/spear1310_evb.c            |  217 +++
 arch/arm/mach-spear13xx/spear13xx.c                | 1163 +++++++++++++
 arch/arm/mach-spear3xx/Kconfig                     |   30 +-
 arch/arm/mach-spear3xx/Kconfig300                  |   17 -
 arch/arm/mach-spear3xx/Kconfig310                  |   17 -
 arch/arm/mach-spear3xx/Kconfig320                  |   17 -
 arch/arm/mach-spear3xx/Makefile                    |    4 +
 arch/arm/mach-spear3xx/clock.c                     |  563 ++++++-
 arch/arm/mach-spear3xx/emi.c                       |  102 ++
 arch/arm/mach-spear3xx/include/mach/emi.h          |   80 +
 arch/arm/mach-spear3xx/include/mach/generic.h      |  282 ++--
 arch/arm/mach-spear3xx/include/mach/gpio.h         |  143 ++
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  206 ++--
 arch/arm/mach-spear3xx/include/mach/misc_regs.h    |   12 +-
 arch/arm/mach-spear3xx/include/mach/spear.h        |  134 +--
 arch/arm/mach-spear3xx/include/mach/spear300.h     |   86 +-
 arch/arm/mach-spear3xx/include/mach/spear310.h     |   85 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h     |  121 +-
 arch/arm/mach-spear3xx/include/mach/suspend.h      |   44 +
 arch/arm/mach-spear3xx/spear300.c                  |  640 ++++++--
 arch/arm/mach-spear3xx/spear300_evb.c              |  138 ++-
 arch/arm/mach-spear3xx/spear310.c                  |  434 ++++--
 arch/arm/mach-spear3xx/spear310_evb.c              |  137 ++-
 arch/arm/mach-spear3xx/spear320.c                  |  855 ++++++++---
 arch/arm/mach-spear3xx/spear320_evb.c              |  154 ++-
 arch/arm/mach-spear3xx/spear3xx.c                  |  742 +++++++--
 arch/arm/mach-spear6xx/Kconfig                     |   15 +-
 arch/arm/mach-spear6xx/Kconfig600                  |   17 -
 arch/arm/mach-spear6xx/clock.c                     |  438 ++++-
 arch/arm/mach-spear6xx/include/mach/generic.h      |   21 +-
 arch/arm/mach-spear6xx/include/mach/gpio.h         |   27 +
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    |   12 +-
 arch/arm/mach-spear6xx/include/mach/spear.h        |  174 +--
 arch/arm/mach-spear6xx/include/mach/suspend.h      |   44 +
 arch/arm/mach-spear6xx/spear600_evb.c              |   80 +-
 arch/arm/mach-spear6xx/spear6xx.c                  |  341 ++++-
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-spear/Kconfig                        |   16 +
 arch/arm/plat-spear/Makefile                       |   21 +-
 arch/arm/plat-spear/clcd.c                         |  126 ++
 arch/arm/plat-spear/clock.c                        |  911 +++++++++--
 arch/arm/plat-spear/cpufreq.c                      |  160 ++
 arch/arm/plat-spear/i2c_eval_board.c               |   29 +
 arch/arm/plat-spear/include/plat/clock.h           |  187 ++-
 arch/arm/plat-spear/include/plat/device.h          |   37 +
 arch/arm/plat-spear/include/plat/fsmc.h            |  158 ++
 arch/arm/plat-spear/include/plat/gpio.h            |   35 +
 arch/arm/plat-spear/include/plat/keyboard.h        |  154 ++
 arch/arm/plat-spear/include/plat/nand.h            |   76 +
 arch/arm/plat-spear/include/plat/padmux.h          |   34 +-
 arch/arm/plat-spear/include/plat/smi.h             |   71 +
 arch/arm/plat-spear/include/plat/spi.h             |   77 +
 arch/arm/plat-spear/padmux.c                       |   54 +-
 arch/arm/plat-spear/plgpio.c                       |  475 ++++++
 arch/arm/plat-spear/pll_clk.S                      |  187 ++
 arch/arm/plat-spear/pm.c                           |  104 ++
 arch/arm/plat-spear/pwm.c                          |  484 ++++++
 arch/arm/plat-spear/sleep.S                        |  288 ++++
 arch/arm/plat-spear/smi.c                          |   63 +
 arch/arm/plat-spear/time.c                         |   34 +-
 drivers/input/keyboard/Kconfig                     |    8 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/spear-keyboard.c            |  335 ++++
 drivers/misc/Kconfig                               |   10 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/spear13xx_pcie_gadget.c               |  888 ++++++++++
 drivers/mtd/devices/Kconfig                        |    7 +
 drivers/mtd/devices/Makefile                       |    1 +
 drivers/mtd/devices/spear_smi.c                    | 1122 +++++++++++++
 drivers/mtd/nand/Kconfig                           |    6 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/spear_nand.c                      |  876 ++++++++++
 drivers/rtc/Kconfig                                |    7 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-spear.c                            |  598 +++++++
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-spear.c                      |  210 +++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 drivers/usb/host/ohci-spear.c                      |  240 +++
 drivers/video/Kconfig                              |   14 +-
 include/mtd/mtd-abi.h                              |    2 +-
 129 files changed, 24444 insertions(+), 2004 deletions(-)
 create mode 100644 arch/arm/configs/spear13xx_defconfig
 delete mode 100644 arch/arm/configs/spear300_defconfig
 delete mode 100644 arch/arm/configs/spear310_defconfig
 delete mode 100644 arch/arm/configs/spear320_defconfig
 create mode 100644 arch/arm/configs/spear3xx_defconfig
 delete mode 100644 arch/arm/configs/spear600_defconfig
 create mode 100644 arch/arm/configs/spear6xx_defconfig
 create mode 100644 arch/arm/mach-spear13xx/Kconfig
 create mode 100644 arch/arm/mach-spear13xx/Makefile
 create mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear13xx/clock.c
 create mode 100644 arch/arm/mach-spear13xx/fsmc-nor.c
 create mode 100644 arch/arm/mach-spear13xx/headsmp.S
 create mode 100644 arch/arm/mach-spear13xx/hotplug.c
 create mode 100644 arch/arm/mach-spear13xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/memory.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/pcie.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/smp.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1300.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/suspend.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/system.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spear13xx/localtimer.c
 create mode 100644 arch/arm/mach-spear13xx/pcie.c
 create mode 100644 arch/arm/mach-spear13xx/platsmp.c
 create mode 100644 arch/arm/mach-spear13xx/pm.c
 create mode 100644 arch/arm/mach-spear13xx/sleep.S
 create mode 100644 arch/arm/mach-spear13xx/spear1300.c
 create mode 100644 arch/arm/mach-spear13xx/spear1300_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear13xx.c
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig300
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig310
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig320
 create mode 100644 arch/arm/mach-spear3xx/emi.c
 create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/suspend.h
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig600
 create mode 100644 arch/arm/mach-spear6xx/include/mach/suspend.h
 create mode 100644 arch/arm/plat-spear/clcd.c
 create mode 100644 arch/arm/plat-spear/cpufreq.c
 create mode 100644 arch/arm/plat-spear/i2c_eval_board.c
 create mode 100644 arch/arm/plat-spear/include/plat/device.h
 create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
 create mode 100644 arch/arm/plat-spear/include/plat/keyboard.h
 create mode 100644 arch/arm/plat-spear/include/plat/nand.h
 create mode 100644 arch/arm/plat-spear/include/plat/smi.h
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h
 create mode 100644 arch/arm/plat-spear/plgpio.c
 create mode 100644 arch/arm/plat-spear/pll_clk.S
 create mode 100644 arch/arm/plat-spear/pm.c
 create mode 100644 arch/arm/plat-spear/pwm.c
 create mode 100644 arch/arm/plat-spear/sleep.S
 create mode 100644 arch/arm/plat-spear/smi.c
 create mode 100644 drivers/input/keyboard/spear-keyboard.c
 create mode 100644 drivers/misc/spear13xx_pcie_gadget.c
 create mode 100644 drivers/mtd/devices/spear_smi.c
 create mode 100644 drivers/mtd/nand/spear_nand.c
 create mode 100644 drivers/rtc/rtc-spear.c
 create mode 100644 drivers/usb/host/ehci-spear.c
 create mode 100644 drivers/usb/host/ohci-spear.c

-- 
1.7.2.2
