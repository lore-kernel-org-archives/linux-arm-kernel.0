From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 11:41:56 +0100
Subject: MXC patches for next merge window
Message-ID: <1258022525-21078-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some patches for the next merge window to review which aim at sound
and add Nand support for the pcm043 board.

Sascha

The following changes since commit 52d797c8c0b53e3940427ff0c43ef4356f1d668e:
  Uwe Kleine-K?nig (1):
        imx/gpio: Use handle_level_irq

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master-pu

Juergen Beisert (2):
      MXC NFC: Add the clock resource to support NFC in i.MX35
      MXC NFC: Fix NFCs address area on i.MX35

Sascha Hauer (7):
      pca100: Add board to uncompress.h
      pca100: use correct irq initialisation function
      pcm043: Add NAND support
      i.MX2: Add sound (ssi) resources
      i.MX3: Add sound (ssi) resources
      MXC: Add a digital audio multiplexer (DAM) driver
      i.MX35: Fix audmux clock

 arch/arm/mach-mx2/Kconfig                   |    2 +
 arch/arm/mach-mx2/clock_imx27.c             |    4 +-
 arch/arm/mach-mx2/devices.c                 |   78 +++++++++++++++++++++++++++
 arch/arm/mach-mx2/devices.h                 |    3 +-
 arch/arm/mach-mx2/pca100.c                  |    2 +-
 arch/arm/mach-mx3/Kconfig                   |    2 +
 arch/arm/mach-mx3/clock-imx35.c             |   41 ++++++++++++--
 arch/arm/mach-mx3/devices.c                 |   44 +++++++++++++++-
 arch/arm/mach-mx3/devices.h                 |    2 +
 arch/arm/mach-mx3/pcm043.c                  |    7 +++
 arch/arm/plat-mxc/Kconfig                   |    7 +++
 arch/arm/plat-mxc/Makefile                  |    2 +
 arch/arm/plat-mxc/dam-v1.c                  |   33 +++++++++++
 arch/arm/plat-mxc/dam-v2.c                  |   56 +++++++++++++++++++
 arch/arm/plat-mxc/include/mach/dam.h        |   45 +++++++++++++++
 arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
 16 files changed, 318 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/plat-mxc/dam-v1.c
 create mode 100644 arch/arm/plat-mxc/dam-v2.c
 create mode 100644 arch/arm/plat-mxc/include/mach/dam.h
