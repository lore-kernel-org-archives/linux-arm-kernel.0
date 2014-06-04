From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jun 2014 15:33:54 +0200
Subject: [PATCH 0/4] <mach/gpio.h> purge
Message-ID: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After deleting <mach/gpio.h> from the AT91 only S5P remains.
This patch set fixes up S5P and then removes NEED_MACH_GPIO_H
permanently removing any references to <mach/gpio.h> from the
ARM kernel. Do a small cleanout of a dangling reference to
ARM_GPIOLIB_COMPLEX at the same time.

Linus Walleij (4):
  ARM: s5p: cut the custom ARCH_NR_GPIOS definition
  ARM: mach-s5p: get rid of all <mach/gpio.h> headers
  ARM: kill CONFIG_NEED_MACH_GPIO_H
  ARM: delete old reference to ARM_GPIOLIB_COMPLEX

 arch/arm/Kconfig                                  |  10 --
 arch/arm/include/asm/gpio.h                       |   7 --
 arch/arm/mach-s5p64x0/common.c                    |   2 +-
 arch/arm/mach-s5p64x0/dev-audio.c                 |   3 +-
 arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h | 127 +++++++++++++++++++
 arch/arm/mach-s5p64x0/include/mach/gpio.h         | 132 --------------------
 arch/arm/mach-s5p64x0/mach-smdk6440.c             |   1 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c             |   1 +
 arch/arm/mach-s5p64x0/setup-fb-24bpp.c            |   2 +-
 arch/arm/mach-s5p64x0/setup-i2c0.c                |   2 +-
 arch/arm/mach-s5p64x0/setup-i2c1.c                |   2 +-
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c          |   2 +-
 arch/arm/mach-s5p64x0/setup-spi.c                 |   2 +-
 arch/arm/mach-s5pc100/dev-audio.c                 |   2 +-
 arch/arm/mach-s5pc100/include/mach/gpio-samsung.h | 140 +++++++++++++++++++++
 arch/arm/mach-s5pc100/include/mach/gpio.h         | 144 ----------------------
 arch/arm/mach-s5pc100/mach-smdkc100.c             |   1 +
 arch/arm/mach-s5pc100/setup-fb-24bpp.c            |   2 +-
 arch/arm/mach-s5pc100/setup-i2c0.c                |   2 +-
 arch/arm/mach-s5pc100/setup-i2c1.c                |   2 +-
 arch/arm/mach-s5pc100/setup-ide.c                 |   2 +-
 arch/arm/mach-s5pc100/setup-keypad.c              |   2 +-
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c          |   2 +-
 arch/arm/mach-s5pc100/setup-spi.c                 |   2 +-
 arch/arm/mach-s5pv210/dev-audio.c                 |   2 +-
 arch/arm/mach-s5pv210/include/mach/gpio-samsung.h | 135 ++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/gpio.h         | 140 ---------------------
 arch/arm/mach-s5pv210/mach-aquila.c               |   1 +
 arch/arm/mach-s5pv210/mach-goni.c                 |   1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c             |   1 +
 arch/arm/mach-s5pv210/setup-fb-24bpp.c            |   2 +-
 arch/arm/mach-s5pv210/setup-fimc.c                |   3 +-
 arch/arm/mach-s5pv210/setup-i2c0.c                |   2 +-
 arch/arm/mach-s5pv210/setup-i2c1.c                |   2 +-
 arch/arm/mach-s5pv210/setup-i2c2.c                |   2 +-
 arch/arm/mach-s5pv210/setup-ide.c                 |   2 +-
 arch/arm/mach-s5pv210/setup-keypad.c              |   2 +-
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c          |   2 +-
 arch/arm/mach-s5pv210/setup-spi.c                 |   2 +-
 arch/arm/plat-samsung/Kconfig                     |  16 ---
 arch/arm/plat-samsung/include/plat/gpio-core.h    |   3 +
 arch/arm/plat-samsung/pm-gpio.c                   |   2 -
 arch/arm/plat-samsung/s5p-irq-eint.c              |   2 +-
 drivers/gpio/gpio-samsung.c                       |   3 -
 sound/soc/samsung/goni_wm8994.c                   |   2 +-
 45 files changed, 440 insertions(+), 481 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio-samsung.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pc100/include/mach/gpio-samsung.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pv210/include/mach/gpio-samsung.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/gpio.h

-- 
1.9.3
