From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:03 -0700
Subject: [PATCH 00/46] davinci updates for 2.6.33
Message-ID: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes various DaVinci platform updates which are
targeted for the next merge window (2.6.33.)

This series based on v2.6.32-rc5 and is available as the
'davinci-next' branch of DaVinci git[1].  This branch is also
automatically included in linux-next.

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary


Chaithrika U S (3):
  davinci: DA850/OMAP-L138 EVM expander setup and UI card detection
  davinci: RMII support for DA850/OMAP-L138 EVM
  davinci: DA850/OMAP-L138: Set ASYNC3 domain flag for McASP

David A. Griego (1):
  davinci: Add MMC/SD support for DA830/OMAP-L137 EVM

Hemant Pedanekar (2):
  davinci: dm646x: Add support for 3.x silicon revision
  davinci: dm646x-evm: Add platform data for NAND

Kevin Hilman (4):
  davinci: da830 EVM: make machine name string consistent with da850
  davinci: da830: add support for new silicon revisions
  davinci: da830 EVM: remove #include <mach/gpio.h>
  davinci: DMx and da8xx defconfig updates

Mark A. Greer (5):
  davinci: Move DA8xx/OMAP-L13x emac register routine
  davinci: Change DA8xx/OMAP-L13x McASP registration routine name
  davinci: Add DA830/OMAP-L137 EVM specific pinmux setting for McASP1
  davinci: Add support for Sharp LCD035Q3DG01 graphical LCD
  davinci: Add RTC support for DA8xx/OMAP-L13x SoC's

Miguel Aguilar (1):
  Davinci: DM365: Add platform device for McBSP

Phaneendra Kumar (1):
  DaVinci: DM365: SDIO interrupt resource correction

Sandeep Paulraj (5):
  DaVinci: DM365: Correct USB parent clock
  DaVinci: EDMA: Fix bug in edma_free_cont_slots API
  DaVinci: EDMA: Fix Bug in edma_alloc_cont_slots API
  DaVinci: EDMA: Fix Bug while obtaining contiguous params
  DaVinci: EDMA: Updating terminlogy in EDMA driver

Sekhar Nori (15):
  davinci: DA8XX/OMAP-L1XX: It's SYSCFG not BOOT_CFG
  davinci: DA8XX/OMAP-L1XX: Avoid use of IO_ADDRESS for SYSCFG module
  davinci: DA8XX/OMAP-L1XX: JTAG ID register should offset from SYSCFG
    base
  davinci: enable easy top down traversal of clock tree
  davinci: make clock rate re-calculation easy
  davinci: support changing the clock rate in clock framework
  davinci: support re-parenting a clock in the clock framework
  davinci: DA850/OMAP-L138: allow async3 source to be changed
  davinci: add generic CPUFreq driver for DaVinci
  davinci: DA850/OMAP-L138: add frequency scaling support
  davinci: DA850/OMAP-L138: add voltage regulation support
  davinci: DA850/OMAP-L138 EVM: register for CPUFreq support
  davinci: DA850/OMAP-L138 EVM: add support for TPS65070 PMIC
  davinci: fix compilation error when using mach/system.h
  davinci: make it easier to identify SoC init failures

Sergei Shtylyov (5):
  davinci: DA8xx: CFGCHIP2 register definitions
  davinci: DA8xx: OHCI platform device
  davinci: DA830 EVM: OHCI platform code
  davinci: DA8xx: rename 'psc_ctlr' field into 'gpsc'
  DaVinci: remove unneeded #include's

Sneha Narnakaje (2):
  davinci: DM355: Update NAND driver platform data
  davinci: DM365: Update NAND driver platform data

Steve Chen (1):
  davinci: Add LCD Graphics support for DA830/OMAP-L137 EVM

Sudhakar Rajashekhara (1):
  davinci: Correct the GPIO number for LCD panel power

 arch/arm/configs/da830_omapl137_defconfig    | 1254 ------------------------
 arch/arm/configs/da850_omapl138_defconfig    | 1229 ------------------------
 arch/arm/configs/da8xx_omapl_defconfig       | 1322 ++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig       |  125 ++-
 arch/arm/mach-davinci/Kconfig                |   54 ++
 arch/arm/mach-davinci/Makefile               |    3 +
 arch/arm/mach-davinci/board-da830-evm.c      |  234 +++++-
 arch/arm/mach-davinci/board-da850-evm.c      |  366 +++++++-
 arch/arm/mach-davinci/board-dm355-evm.c      |   12 +-
 arch/arm/mach-davinci/board-dm355-leopard.c  |    9 +-
 arch/arm/mach-davinci/board-dm365-evm.c      |   18 +-
 arch/arm/mach-davinci/board-dm644x-evm.c     |   12 -
 arch/arm/mach-davinci/board-dm646x-evm.c     |   84 ++-
 arch/arm/mach-davinci/board-sffsdr.c         |   12 -
 arch/arm/mach-davinci/clock.c                |  227 ++++-
 arch/arm/mach-davinci/clock.h                |   17 +-
 arch/arm/mach-davinci/common.c               |    4 +-
 arch/arm/mach-davinci/cp_intc.c              |    3 -
 arch/arm/mach-davinci/cpufreq.c              |  219 +++++
 arch/arm/mach-davinci/da830.c                |   75 +-
 arch/arm/mach-davinci/da850.c                |  302 ++++++-
 arch/arm/mach-davinci/devices-da8xx.c        |   76 ++-
 arch/arm/mach-davinci/devices.c              |    6 +-
 arch/arm/mach-davinci/dm355.c                |    2 -
 arch/arm/mach-davinci/dm365.c                |   49 +-
 arch/arm/mach-davinci/dm644x.c               |    2 -
 arch/arm/mach-davinci/dm646x.c               |   11 +-
 arch/arm/mach-davinci/dma.c                  |  105 ++-
 arch/arm/mach-davinci/gpio.c                 |    9 -
 arch/arm/mach-davinci/include/mach/asp.h     |    3 +
 arch/arm/mach-davinci/include/mach/cpufreq.h |   25 +
 arch/arm/mach-davinci/include/mach/da8xx.h   |   23 +-
 arch/arm/mach-davinci/include/mach/dm365.h   |    2 +
 arch/arm/mach-davinci/include/mach/dm644x.h  |    1 -
 arch/arm/mach-davinci/include/mach/mux.h     |   11 +-
 arch/arm/mach-davinci/include/mach/system.h  |    3 +-
 arch/arm/mach-davinci/include/mach/usb.h     |   57 ++
 arch/arm/mach-davinci/mux.c                  |    1 -
 arch/arm/mach-davinci/psc.c                  |    3 -
 arch/arm/mach-davinci/serial.c               |    6 -
 arch/arm/mach-davinci/sram.c                 |    3 -
 arch/arm/mach-davinci/time.c                 |    6 -
 arch/arm/mach-davinci/usb.c                  |   41 +-
 43 files changed, 3186 insertions(+), 2840 deletions(-)
 delete mode 100644 arch/arm/configs/da830_omapl137_defconfig
 delete mode 100644 arch/arm/configs/da850_omapl138_defconfig
 create mode 100644 arch/arm/configs/da8xx_omapl_defconfig
 create mode 100644 arch/arm/mach-davinci/cpufreq.c
 create mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h
 create mode 100644 arch/arm/mach-davinci/include/mach/usb.h
