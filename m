From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 May 2011 22:52:15 +0800
Subject: [PATCH 0/4] Move plat-mxc gpio driver into drivers/gpio
Message-ID: <1306767139-24763-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set moves plat-mxc gpio driver into drivers/gpio.  It's
based on the following tree, plus Sascha's i.MX consolidation
patches.

    git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-3.0

Shawn Guo (4):
      gpio: gpio-mxc: add gpio driver for Freescale MXC architecture
      ARM: mxc: migrate mach-mx5 gpio driver to gpio-mxc
      ARM: mxc: migrate mach-imx gpio driver to gpio-mxc
      ARM: mxc: remove plat-mxc/gpio driver

 arch/arm/mach-imx/mm-imx1.c                        |    9 -
 arch/arm/mach-imx/mm-imx21.c                       |   11 -
 arch/arm/mach-imx/mm-imx25.c                       |    9 -
 arch/arm/mach-imx/mm-imx27.c                       |   11 -
 arch/arm/mach-imx/mm-imx31.c                       |    8 -
 arch/arm/mach-imx/mm-imx35.c                       |    8 -
 arch/arm/mach-mx5/devices.c                        |   64 ------
 arch/arm/mach-mx5/mm-mx50.c                        |   11 -
 arch/arm/mach-mx5/mm.c                             |    6 -
 arch/arm/plat-mxc/Makefile                         |    2 +-
 arch/arm/plat-mxc/devices.c                        |   11 +
 arch/arm/plat-mxc/devices/Makefile                 |    1 +
 arch/arm/plat-mxc/devices/platform-gpio-mxc.c      |  113 ++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h    |    2 +
 arch/arm/plat-mxc/include/mach/gpio.h              |   27 ---
 drivers/gpio/Makefile                              |    1 +
 .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c |  218 +++++++++++++-------
 17 files changed, 275 insertions(+), 237 deletions(-)
