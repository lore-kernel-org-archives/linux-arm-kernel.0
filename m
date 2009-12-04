From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 4 Dec 2009 13:43:01 +0100
Subject: Please pull mxc patches
Message-ID: <20091204124301.GR15126@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit
4998f1a30cf8e21c5bc0766fde4fa58e1adabd72:
  Sascha Hauer (1):
        mxc: mx1/mx2 DMA: add a possibility to create an endless DMA
transfer

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Alan Carvalho de Assis (2):
      mx27: Add basic support for Maxtrack i-MXT TD60
      mx27: mxt_td60: Add support to SD/MMC

Harro Haan (2):
      mx35: register usb_ahb clock in clock-imx35.c
      mx35: add usb gadget support in mx35pdk.c

Robert Schwebel (1):
      mx31moboard: fix typo

Sascha Hauer (1):
      i.MX27 audmux: Fix register offsets

Uwe Kleine-K?nig (2):
      IMX: don't disable the uart clock if DEBUG_LL uses it
      MAINTAINERS: add tree and file pattern for ARM IMX

Yoichi Yuasa (1):
      Add KZM-ARM11-01 support

 MAINTAINERS                                     |    3 +
 arch/arm/configs/mx3_defconfig                  |  101 +++++---
 arch/arm/mach-mx2/Kconfig                       |    7 +
 arch/arm/mach-mx2/Makefile                      |    1 +
 arch/arm/mach-mx2/clock_imx21.c                 |    2 +-
 arch/arm/mach-mx2/clock_imx27.c                 |    2 +-
 arch/arm/mach-mx2/mxt_td60.c                    |  319 +++++++++++++++++++++++
 arch/arm/mach-mx3/Kconfig                       |    8 +
 arch/arm/mach-mx3/Makefile                      |    1 +
 arch/arm/mach-mx3/clock-imx35.c                 |    5 +-
 arch/arm/mach-mx3/kzmarm11.c                    |  268 +++++++++++++++++++
 arch/arm/mach-mx3/mx31moboard.c                 |    2 +-
 arch/arm/mach-mx3/mx35pdk.c                     |   12 +
 arch/arm/plat-mxc/audmux-v1.c                   |    9 +-
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h |   39 +++
 arch/arm/plat-mxc/include/mach/iomux-mx3.h      |    8 +
 arch/arm/plat-mxc/include/mach/iomux.h          |    1 +
 arch/arm/plat-mxc/include/mach/uncompress.h     |    1 +
 18 files changed, 750 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/mach-mx2/mxt_td60.c
 create mode 100644 arch/arm/mach-mx3/kzmarm11.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
