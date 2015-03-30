From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Mar 2015 22:02:09 +0800
Subject: [GIT PULL 1/4] ARM: imx: cleanup for 4.1
Message-ID: <CAAQ0ZWQXUJ0O+WBojuoTscW0L1tAGxR3JWYL0=7Jaej5D7zGJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
tags/imx-cleanup-4.1

for you to fetch changes up to dc98b0cb6175016f31c8ef1685dd0d69476aa495:

  ARM: imx_v4_v5_defconfig: Remove CONFIG_MACH_MX25_3DS (2015-03-13
22:14:59 +0800)

----------------------------------------------------------------
The i.MX cleanup for v4.1:
 - Convert i.MX25 to be a DT only platform and remove the code that is
   only used by non-DT support
 - A couple trivial cleanup on iomux-v3 code

----------------------------------------------------------------
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

Uwe Kleine-K?nig (1):
      ARM: imx/iomux-v3: allow pad_list to be const

Yannick Guerrini (1):
      ARM: imx: Fix trivial typo in comments

 arch/arm/configs/imx_v4_v5_defconfig              |   3 +-
 arch/arm/configs/multi_v5_defconfig               |   2 +-
 arch/arm/mach-imx/Kconfig                         |  81 +---
 arch/arm/mach-imx/Makefile                        |   8 +-
 arch/arm/mach-imx/clk-imx25.c                     |  75 ----
 arch/arm/mach-imx/common.h                        |   5 -
 arch/arm/mach-imx/cpu-imx25.c                     |  11 +-
 arch/arm/mach-imx/devices-imx25.h                 |  85 ----
 arch/arm/mach-imx/devices/Kconfig                 |   3 -
 arch/arm/mach-imx/devices/Makefile                |   1 -
 arch/arm/mach-imx/devices/platform-fec.c          |   5 -
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   5 -
 arch/arm/mach-imx/devices/platform-imx-fb.c       |   5 -
 arch/arm/mach-imx/devices/platform-imx-i2c.c      |  10 -
 arch/arm/mach-imx/devices/platform-imx-keypad.c   |   5 -
 arch/arm/mach-imx/devices/platform-imx-ssi.c      |   9 -
 arch/arm/mach-imx/devices/platform-imx-uart.c     |  12 -
 arch/arm/mach-imx/devices/platform-imx2-wdt.c     |   5 -
 arch/arm/mach-imx/devices/platform-imxdi_rtc.c    |  42 --
 arch/arm/mach-imx/devices/platform-mx2-camera.c   |   5 -
 arch/arm/mach-imx/devices/platform-mxc-ehci.c     |   7 -
 arch/arm/mach-imx/devices/platform-mxc_nand.c     |   5 -
 arch/arm/mach-imx/devices/platform-spi_imx.c      |  11 -
 arch/arm/mach-imx/ehci-imx25.c                    |  99 ----
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c    | 310 -------------
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c    |   2 +-
 arch/arm/mach-imx/hardware.h                      |   1 -
 arch/arm/mach-imx/iomux-mx25.h                    | 524 ----------------------
 arch/arm/mach-imx/iomux-mx3.h                     |   2 +-
 arch/arm/mach-imx/iomux-v3.c                      |   5 +-
 arch/arm/mach-imx/iomux-v3.h                      |   5 +-
 arch/arm/mach-imx/mach-cpuimx35.c                 |   2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c          | 172 -------
 arch/arm/mach-imx/{imx25-dt.c => mach-imx25.c}    |  20 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                 | 270 -----------
 arch/arm/mach-imx/mach-mx35_3ds.c                 |   2 +-
 arch/arm/mach-imx/mach-pcm043.c                   |   2 +-
 arch/arm/mach-imx/mach-vpr200.c                   |   2 +-
 arch/arm/mach-imx/mm-imx25.c                      |  89 ----
 arch/arm/mach-imx/mx25.h                          | 117 -----
 40 files changed, 59 insertions(+), 1965 deletions(-)
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
