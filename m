From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 11 Jun 2010 17:33:14 +0900
Subject: [PATCH v2 0/4] ARM: S5P: Support gpio interrupts
Message-ID: <4C11F4CA.10802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch v2 set is to support gpio interrupts of samsung s5p cpus, and
the GPIOlib gpio_to_irq goes to plat-samsung gpiolib, so patch v2 set 
has four commit smaller than v1.

Changes since v1:
- Add irq_base to s3c_gpio_chip struct 
- GPIOlib gpio_to_irq() is implemented to samsung_gpiolib_to_irq() of
  plat-samsung gpiolib

Joonyoung Shim (4):
      ARM: S5PV210: Add gpio interrupt support
      ARM: S5PC100: Use S5P gpio interrupts interface
      ARM: S5PC100: Move external interrupt defines
      ARM: SAMSUNG: Add GPIOlib gpio_to_irq

 arch/arm/mach-s5pc100/Makefile                 |    2 +-
 arch/arm/mach-s5pc100/gpiolib.c                |   70 ++-----
 arch/arm/mach-s5pc100/include/mach/gpio.h      |    7 -
 arch/arm/mach-s5pc100/include/mach/irqs.h      |   18 ++-
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h |    7 +
 arch/arm/mach-s5pc100/irq-gpio.c               |  266 ------------------------
 arch/arm/mach-s5pv210/gpiolib.c                |   18 ++-
 arch/arm/mach-s5pv210/include/mach/irqs.h      |   16 ++-
 arch/arm/plat-s5p/Makefile                     |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c                |  208 ++++++++++++++++++
 arch/arm/plat-samsung/gpiolib.c                |    9 +
 arch/arm/plat-samsung/include/plat/gpio-core.h |    6 +
 12 files changed, 295 insertions(+), 334 deletions(-)
 delete mode 100644 arch/arm/mach-s5pc100/irq-gpio.c
 create mode 100644 arch/arm/plat-s5p/irq-gpioint.c
