From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:41:28 +0530
Subject: [PATCH V4 00/62] Updating SPEAr Support
Message-ID: <cover.1295333957.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following set of patches:
- updates SPEAr3xx, 6xx support
- Adds support for SPEAr13xx
- Removes Multiple defconfigs per machine family

Changes since V3:
- SPEAr13xx: gic init, smp and hotplug code updated w.r.t. latest linus/master
- Appending UL to VMALLOC_END Macros
- readl & writle _relaxed used instread _raw in uncompress.h
- infinite loop removed from arch_reset() in
  mach-spear13xx/include/mach/system.h
- patch: ST-SPEAr13xx-Modified-static-mappings is broken into two patches.
  Now, static mapping for SPEAr1310 RAS will be present only on 1310 machine.
- Updated commit message of: SPEAr Power Management: Added the support for
  Standby mode
- Default ssp freq changed to 25MHz.
- patch: ST-SPEAr-13xx-Adding-support-for-SPEAr1310 is splitted into two
  patches. Separate patch for 320 CAN is added.
- Wrapper routine spi_init() in spear*evb.c files is removed.
- routine i2c_register_board_devices() is renamed to
  i2c_register_default_devices() in arch/arm/plat-spear/i2c_eval_board.c file
- Following patches are removed from this patchset, they will be added
  separately:
	ST-SPEAr-FSMC-Flexible-Static-Memory-Controller-NOR-.patch
- Following patches are already present in linus-next or already Acked, so they
  are also removed from this patchset:
	Newly-erased-page-read-workaround.patch

Changes since V2:
- Following patches are removed from this patchset, as they are still under
  review:
	ST SPEAr: PCIE gadget suppport
	ST SPEAr13xx: Adding machine support for pci gadget
	ST SPEAr: Add smi driver for serial NOR flash
	ST SPEAr: Adding support for serial nor flash in all spear platforms
- Following patches are already present in linus-next, so they are also removed
  from this patchset:
	mtd/fsmc.h: including linux/io.h for definition of readl
	Keyboard: Adding support for spear-keyboard
	USB host: Adding USB ehci & ohci support for spear platform
- spear-keyboard machine support is updated according to updations in driver
  (driver is already in linus-next)
- rtc driver is updated and ioctl routine is removed.

Changes since V1:
- sev definitions moved to system.h and removed from spear and omap archs
- bug fix added in system controller file sp810.h
- Review Comments incorporated
- Driver and machine support are divided into separate patches
- Nand Driver is removed from patch list as it is already floated by Linus
  Walleij.
- Few later patches of SPEAr13xx Patches are merged with initial patches of
  SPEAr13xx
- Smaller Defconfigs are used instead of large.
- Clock renaming & minor corrections are moved to clock specific patches from
  peripheral machine support patches.
- Removed Commented code related to SPI
- [PATCH] Incrementing the ecc_pos array to contain 128 char - is removed from
  list
- Board specific code is moved to *evb.c files from machine files for EMI NOR
- replaced readl with __raw_readl in uncompress.h in plat-spear/include/plat/

Rebased over linus: v2.6.37
e6f597a1425b5af64917be3448b29e2d5a585ac8


Bhupesh Sharma (1):
  ST SPEAr 13xx : Adding support for SPEAr1310

Deepak Sikri (5):
  ST SPEAr: Adding machine support for USB host
  SPEAr Clock Framework: Adding support for PLL frequency change
  SPEAr Power Management: Added the support for Standby mode.
  SPEAr CPU freq: Adding support for CPU Freq framework
  ST SPEAr13xx: Adding CPU hotplug support added for SMP platforms

Pratyush Anand (1):
  ST SPEAr: Added PCIE host controller base driver support.

Rajeev Kumar (4):
  rtc: Adding support for spear rtc
  ST SPEAr: Adding machine support for rtc-spear
  ST SPEAr: adding support for synopsis i2c designware
  ST SPEAr: Adding machine support for keyboard

Ryan Mallon (5):
  SPEAr3xx: Make local structures static
  SPEAR3xx: Rename register/irq defines to remove naming conflicts
  SPEAr3xx: Rework pmx_dev code to remove conflicts
  SPEAr3xx: Rework KConfig to allow all boards to be compiled in
  SPEAr3xx: Replace defconfigs with single unified defconfig

Shiraz Hashim (13):
  sp810 Fix: Switch to slow mode before sysctl_soft_reset
  ST SPEAr: Formalized timer support
  ST SPEAr13XX: Adding machine specific header files
  ST SPEAr13XX: Adding machine specific src files
  ST SPEAr: Adding support for SPEAr13xx SoC in spear generic plat/
  ST SPEAr13XX: Added compilation support in arch/arm/
  ST SPEAr13xx: Adding default config file
  ST SPEAr: Adding Debugfs support on clock framework
  ST SPEAr: Replacing SIZE macro's with actual required size
  SPEAr: defines base addresses as ulong.
  ST SPEAr13xx: add L2 cache support
  ST SPEAr13xx: Modified static mappings
  ST SPEAr: Adding information in Documentation/ and MAINTAINERS

Vipin Kumar (5):
  ST SPEAr: Adding machine support for nand
  ST SPEAr : EMI (Extrenal Memory Interface) controller driver
  SPEAr : Pad multiplexing handling modified
  SPEAr13xx : Fixed part devices in SPEAr13xx addded to the generic
    implementation
  SPEAr : Updating pad multiplexing support

Vipul-kumar Samar (1):
  ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx

Viresh Kumar (27):
  spear/vmalloc.h: Appending UL to VMALLOC_END
  ST SPEAr: Padmux code Updated
  ST SPEAr: Making clock functions more generic
  ST SPEAr: Updating Clock Support
  ST SPEAr: Correcting SOC Config base address for spear320
  ST SPEAr: Adding PLGPIO driver for spear platform
  ST SPEAr: Added ARM PL061 GPIO Support on SPEAr13xx and modified
    resource size
  ST SPEAr: Adding support for ST's PWM IP
  ST SPEAr: Adding Watchdog support
  ST SPEAr: Adding support for SSP PL022
  ST SPEAr: Adding support for SDHCI (SDIO)
  ST SPEAr: Changing resource size of amba devices to SZ_4K
  ST SPEAr: Adding miscellaneous devices
  SPEAr320: Adding support for CAN
  ST SPEAr: Adding support for DDR in clock framework
  ST SPEAr: replace readl, writel with readl_relaxed, writel_relaxed in
    uncompress.h
  SPEAr1310: Adding Static Mapping for RAS Area
  SPEAr: Adding and Updating Clock definitions
  ST SPEAr3xx: Passing pmx devices address from machine *.c files
  ST SPEAr Clock Framework: Updating for single image solution
  ST SPEAr: Appending spear3** with global structures
  ST SPEAr3xx: Updating plgpio and emi source to make it compliant with
    single image strategy
  SPEAr6xx: Rework Kconfig for single image solution
  ST SPEAR6xx: renaming spear600_defconfig as spear6xx_defconfig
  ST SPEAr13xx: Pass default padmux settings as parameter to
    spear13**_init routine
  ST SPEAr: Adding devices & clocks
  ST SPEAr: Updating defconfigs

 Documentation/arm/SPEAr/overview.txt               |   34 +-
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    6 +-
 arch/arm/Makefile                                  |    2 +
 arch/arm/configs/spear13xx_defconfig               |  127 ++
 arch/arm/configs/spear300_defconfig                |   51 -
 arch/arm/configs/spear310_defconfig                |   52 -
 arch/arm/configs/spear320_defconfig                |   52 -
 arch/arm/configs/spear3xx_defconfig                |  119 ++
 arch/arm/configs/spear600_defconfig                |   49 -
 arch/arm/configs/spear6xx_defconfig                |  109 ++
 arch/arm/include/asm/hardware/sp810.h              |    3 +
 arch/arm/mach-spear13xx/Kconfig                    |   32 +
 arch/arm/mach-spear13xx/Makefile                   |   23 +
 arch/arm/mach-spear13xx/Makefile.boot              |    3 +
 arch/arm/mach-spear13xx/clock.c                    | 1204 ++++++++++++++++++++
 arch/arm/mach-spear13xx/headsmp.S                  |   96 ++
 arch/arm/mach-spear13xx/hotplug.c                  |  121 ++
 arch/arm/mach-spear13xx/include/mach/clkdev.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear13xx/include/mach/entry-macro.S |   22 +
 arch/arm/mach-spear13xx/include/mach/generic.h     |  275 +++++
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   37 +
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   37 +
 arch/arm/mach-spear13xx/include/mach/io.h          |   19 +
 arch/arm/mach-spear13xx/include/mach/irqs.h        |  153 +++
 arch/arm/mach-spear13xx/include/mach/memory.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/misc_regs.h   |  386 +++++++
 arch/arm/mach-spear13xx/include/mach/pcie.h        |  170 +++
 arch/arm/mach-spear13xx/include/mach/smp.h         |   25 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |   95 ++
 arch/arm/mach-spear13xx/include/mach/spear1300.h   |   21 +
 arch/arm/mach-spear13xx/include/mach/spear1310.h   |   64 +
 arch/arm/mach-spear13xx/include/mach/suspend.h     |   47 +
 arch/arm/mach-spear13xx/include/mach/system.h      |   35 +
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear13xx/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-spear13xx/localtimer.c               |   25 +
 arch/arm/mach-spear13xx/pcie.c                     |  861 ++++++++++++++
 arch/arm/mach-spear13xx/platsmp.c                  |  165 +++
 arch/arm/mach-spear13xx/pm.c                       |  107 ++
 arch/arm/mach-spear13xx/sleep.S                    |  435 +++++++
 arch/arm/mach-spear13xx/spear1300.c                |   38 +
 arch/arm/mach-spear13xx/spear1300_evb.c            |  146 +++
 arch/arm/mach-spear13xx/spear1310.c                |  516 +++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c            |  166 +++
 arch/arm/mach-spear13xx/spear13xx.c                | 1057 +++++++++++++++++
 arch/arm/mach-spear3xx/Kconfig                     |   30 +-
 arch/arm/mach-spear3xx/Kconfig300                  |   17 -
 arch/arm/mach-spear3xx/Kconfig310                  |   17 -
 arch/arm/mach-spear3xx/Kconfig320                  |   17 -
 arch/arm/mach-spear3xx/Makefile                    |    4 +
 arch/arm/mach-spear3xx/clock.c                     |  576 ++++++++--
 arch/arm/mach-spear3xx/emi.c                       |  117 ++
 arch/arm/mach-spear3xx/include/mach/emi.h          |   65 ++
 arch/arm/mach-spear3xx/include/mach/generic.h      |  280 +++--
 arch/arm/mach-spear3xx/include/mach/gpio.h         |  143 +++
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  206 ++--
 arch/arm/mach-spear3xx/include/mach/misc_regs.h    |   12 +-
 arch/arm/mach-spear3xx/include/mach/spear.h        |  134 +--
 arch/arm/mach-spear3xx/include/mach/spear300.h     |   86 +-
 arch/arm/mach-spear3xx/include/mach/spear310.h     |   85 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h     |  121 +--
 arch/arm/mach-spear3xx/include/mach/suspend.h      |   44 +
 arch/arm/mach-spear3xx/spear300.c                  |  640 ++++++++---
 arch/arm/mach-spear3xx/spear300_evb.c              |  109 ++-
 arch/arm/mach-spear3xx/spear310.c                  |  423 ++++++--
 arch/arm/mach-spear3xx/spear310_evb.c              |  135 ++-
 arch/arm/mach-spear3xx/spear320.c                  |  844 +++++++++++----
 arch/arm/mach-spear3xx/spear320_evb.c              |  120 ++-
 arch/arm/mach-spear3xx/spear3xx.c                  |  741 ++++++++++---
 arch/arm/mach-spear6xx/Kconfig                     |   15 +-
 arch/arm/mach-spear6xx/Kconfig600                  |   17 -
 arch/arm/mach-spear6xx/clock.c                     |  438 ++++++--
 arch/arm/mach-spear6xx/include/mach/generic.h      |   19 +-
 arch/arm/mach-spear6xx/include/mach/gpio.h         |   27 +
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    |   12 +-
 arch/arm/mach-spear6xx/include/mach/spear.h        |  174 +---
 arch/arm/mach-spear6xx/include/mach/suspend.h      |   44 +
 arch/arm/mach-spear6xx/spear600_evb.c              |   35 +-
 arch/arm/mach-spear6xx/spear6xx.c                  |  344 ++++++-
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-spear/Kconfig                        |   17 +
 arch/arm/plat-spear/Makefile                       |   21 +-
 arch/arm/plat-spear/clcd.c                         |  114 ++
 arch/arm/plat-spear/clock.c                        |  905 +++++++++++++---
 arch/arm/plat-spear/cpufreq.c                      |  159 +++
 arch/arm/plat-spear/i2c_eval_board.c               |   29 +
 arch/arm/plat-spear/include/plat/clock.h           |  187 +++-
 arch/arm/plat-spear/include/plat/fsmc.h            |   36 +
 arch/arm/plat-spear/include/plat/gpio.h            |   35 +
 arch/arm/plat-spear/include/plat/padmux.h          |   34 +-
 arch/arm/plat-spear/include/plat/spi.h             |   74 ++
 arch/arm/plat-spear/include/plat/uncompress.h      |    4 +-
 arch/arm/plat-spear/include/plat/vmalloc.h         |    2 +-
 arch/arm/plat-spear/padmux.c                       |   54 +-
 arch/arm/plat-spear/plgpio.c                       |  474 ++++++++
 arch/arm/plat-spear/pll_clk.S                      |  187 +++
 arch/arm/plat-spear/pm.c                           |  104 ++
 arch/arm/plat-spear/pwm.c                          |  484 ++++++++
 arch/arm/plat-spear/sleep.S                        |  288 +++++
 arch/arm/plat-spear/time.c                         |   21 +-
 drivers/rtc/Kconfig                                |    8 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-spear.c                            |  534 +++++++++
 drivers/video/Kconfig                              |   14 +-
 107 files changed, 14992 insertions(+), 1986 deletions(-)
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
 create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h
 create mode 100644 arch/arm/plat-spear/plgpio.c
 create mode 100644 arch/arm/plat-spear/pll_clk.S
 create mode 100644 arch/arm/plat-spear/pm.c
 create mode 100644 arch/arm/plat-spear/pwm.c
 create mode 100644 arch/arm/plat-spear/sleep.S
 create mode 100644 drivers/rtc/rtc-spear.c

-- 
1.7.2.2
