From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 03 Jun 2010 14:05:27 +0900
Subject: [PATCH 0/7] ARM: S5P: Support gpio interrupts and GPIOlib gpio_to_irq
Message-ID: <4C073817.7020000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to support gpio interrupts and GPIOlib gpio_to_irq of
gpio and external interrupts at the samsung s5p cpus.

---
Joonyoung Shim (7):
      ARM: S5PC100: Move external interrupt defines
      ARM: S5P: Add GPIOlib gpio_to_irq for external interrupts
      ARM: S5PV210: Support GPIOlib gpio_to_irq for external interrupts
      ARM: S5PC100: Use S5P GPIOlib gpio_to_irq function for external interrupts
      ARM: S5PV210: Add gpio interrupt support
      ARM: S5PC100: Use S5P gpio interrupts interface
      ARM: S5P: Add GPIOlib gpio_to_irq for gpio interrupts

 arch/arm/mach-s5pc100/Makefile                 |    2 +-
 arch/arm/mach-s5pc100/gpiolib.c                |   65 +-----
 arch/arm/mach-s5pc100/include/mach/gpio.h      |    7 -
 arch/arm/mach-s5pc100/include/mach/irqs.h      |   18 ++-
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h |    7 +
 arch/arm/mach-s5pc100/irq-gpio.c               |  266 ------------------------
 arch/arm/mach-s5pv210/gpiolib.c                |   13 +-
 arch/arm/mach-s5pv210/include/mach/irqs.h      |   16 ++-
 arch/arm/plat-s5p/Makefile                     |    3 +-
 arch/arm/plat-s5p/gpiolib.c                    |   42 ++++
 arch/arm/plat-s5p/irq-gpioint.c                |  208 ++++++++++++++++++
 arch/arm/plat-samsung/include/plat/gpio-core.h |    6 +
 12 files changed, 319 insertions(+), 334 deletions(-)
 delete mode 100644 arch/arm/mach-s5pc100/irq-gpio.c
 create mode 100644 arch/arm/plat-s5p/gpiolib.c
 create mode 100644 arch/arm/plat-s5p/irq-gpioint.c
