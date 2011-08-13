From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 14 Aug 2011 00:13:59 +0800
Subject: [PATCH v2 0/8] Clean up MXC and MXS mach/gpio.h
Message-ID: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As one step to single image for multiple platforms, mach/gpio.h needs
to be removed from asm/gpio.h.  The patch set cleans up MXC and MXS
mach/gpio.h to an empty header.

It's based on v3.1-rc1 plus rmk's patch series below.

  [PATCH 00/13] Clean up mach/gpio.h headers

The Ben's fix is on the way to -rc2 through arm-soc tree.

Grant, Sascha,

Can you please review the series and give comments or your ack tag?

Regards,
Shawn

Changes since v1:
 * Add patches #7 and #8 to clean up mxs mach/gpio.h
 * Leave run-time gpio_to_irq() calls there and only convert these
   in static initializers to IMX_GPIO_TO_IRQ()
 * Mark the empty headers with /* empty */

Ben Dooks (1):
      ARM: mx5: board-cpuimx51.c fixup irq_to_gpio() usage

Shawn Guo (7):
      arm/mxc: do not use gpio_to_irq() for static initializers
      gpio/mxc: add .to_irq for gpio chip
      arm/mxc: remove gpio_to_irq() from mach/gpio.h
      gpio/mxc: move irq_to_gpio() into gpio-mxc driver
      arm/mxc: move IMX_GPIO_NR into mach/hardware.h
      gpio/mxs: move irq_to_gpio() into gpio-mxs driver
      arm/mxs: move MXS_GPIO_NR into mach/mxs.h

 arch/arm/mach-imx/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-vpr200.c              |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c           |    8 +++---
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    4 +-
 arch/arm/mach-mx5/board-mx53_ard.c           |    4 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    2 +-
 arch/arm/mach-mx5/mx51_efika.c               |    2 +-
 arch/arm/mach-mxs/include/mach/gpio.h        |   28 +--------------------
 arch/arm/mach-mxs/include/mach/mxs.h         |    2 +
 arch/arm/plat-mxc/include/mach/gpio.h        |   34 +-------------------------
 arch/arm/plat-mxc/include/mach/hardware.h    |    6 ++++
 drivers/gpio/gpio-mxc.c                      |   12 +++++++++
 drivers/gpio/gpio-mxs.c                      |    2 +
 14 files changed, 37 insertions(+), 73 deletions(-)
