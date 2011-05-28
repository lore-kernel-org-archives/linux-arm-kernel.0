From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 May 2011 23:09:32 +0800
Subject: [PATCH v2 0/2] Move Freescale MXS gpio driver into drivers/gpio
Message-ID: <1306595374-25178-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set moves Freescale MXS gpio driver from mach-mxs into
drivers/gpio.

Changes since v1:
 * Squash the 4 gpio-mxs patches into one
 * Do not add new gpio Kconfig option and use ARCH_MXS directly
 * Clean up platform-gpio-mxs.c per Arnd's comments
 * Add device mxs_apbh_bus and set it as the parent of gpio devices

Shawn Guo (2):
      gpio: gpio-mxs: add gpio driver for Freescale MXS architecture
      ARM: mxs: use gpio-mxs driver by adding platform device

 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/devices.c                        |   11 +
 arch/arm/mach-mxs/devices/Makefile                 |    1 +
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   53 +++++
 arch/arm/mach-mxs/gpio.h                           |   34 ---
 arch/arm/mach-mxs/include/mach/devices-common.h    |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                   |    1 -
 arch/arm/mach-mxs/mm-mx23.c                        |    1 -
 arch/arm/mach-mxs/mm-mx28.c                        |    1 -
 drivers/gpio/Makefile                              |    1 +
 .../arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c |  228 ++++++++++++--------
