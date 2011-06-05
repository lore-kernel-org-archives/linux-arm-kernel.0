From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  5 Jun 2011 23:59:02 +0800
Subject: [PATCH v4 0/3] Move Freescale MXS gpio driver into drivers/gpio
Message-ID: <1307289545-6993-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set moves Freescale MXS gpio driver from mach-mxs into
drivers/gpio.

Changes since v3:
 * Reorganize the patch set per Grant's comments

Grant Likely (1):
      gpio/mxs: Move Freescale mxs gpio driver to drivers/gpio

Shawn Guo (2):
      gpio/mxs: Change gpio-mxs into an upstanding gpio driver
      gpio/mxs: Remove the use of gpio-mxs.h

 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/devices.c                        |   11 +
 arch/arm/mach-mxs/devices/Makefile                 |    1 +
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   53 +++++
 arch/arm/mach-mxs/gpio.h                           |   34 ---
 arch/arm/mach-mxs/include/mach/devices-common.h    |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                   |    1 -
 arch/arm/mach-mxs/mm-mx23.c                        |    1 -
 arch/arm/mach-mxs/mm-mx28.c                        |    1 -
 drivers/gpio/Kconfig                               |    4 +
 drivers/gpio/Makefile                              |    1 +
 .../arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c |  227 ++++++++++++--------
 12 files changed, 206 insertions(+), 132 deletions(-)
