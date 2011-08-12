From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Aug 2011 15:54:55 +0800
Subject: [PATCH 0/6] Clean up plat-mxc/include/mach/gpio.h
Message-ID: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As one step to single image for multiple platforms, mach/gpio.h needs
to be removed from asm/gpio.h.  The patch set cleans up IMX/MXC
mach/gpio.h to an empty header.

It's based on v3.1-rc1 plus rmk's patch series below.

  [PATCH 00/13] Clean up mach/gpio.h headers

Shawn Guo (6):
      arm/cpuimx51: gpio_to_irq() should be used to get irq from gpio number
      arm/imx: remove the uses of gpio_to_irq()
      gpio/mxc: add .to_irq for gpio chip
      arm/imx: remove gpio_to_irq() from mach/gpio.h
      gpio/mxc: move irq_to_gpio() into gpio-mxc driver
      arm/mxc: move IMX_GPIO_NR into mach/hardware.h

 arch/arm/mach-imx/mach-armadillo5x0.c        |    3 ++-
 arch/arm/mach-imx/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    8 ++++----
 arch/arm/mach-imx/mach-mx31moboard.c         |    4 ++--
 arch/arm/mach-imx/mach-mx35_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-vpr200.c              |    2 +-
 arch/arm/mach-imx/mx31moboard-devboard.c     |    4 ++--
 arch/arm/mach-imx/mx31moboard-marxbot.c      |    4 ++--
 arch/arm/mach-mx5/board-cpuimx51.c           |    8 ++++----
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    4 ++--
 arch/arm/mach-mx5/board-mx51_3ds.c           |    2 +-
 arch/arm/mach-mx5/board-mx53_ard.c           |    4 ++--
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    4 ++--
 arch/arm/mach-mx5/mx51_efika.c               |    2 +-
 arch/arm/plat-mxc/include/mach/gpio.h        |   11 -----------
 arch/arm/plat-mxc/include/mach/hardware.h    |    6 ++++++
 drivers/gpio/gpio-mxc.c                      |   12 ++++++++++++
