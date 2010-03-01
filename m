From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 1 Mar 2010 15:04:25 +0530
Subject: [PATCH 0/5] ux500: gpio support
Message-ID: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the GPIOs on the Ux500 platform.

Rabin Vincent (5):
  nomadik: move gpio to plat-nomadik
  nomadik-gpio: fix spinlock usage
  nomadik-gpio: mask/ack/unmask the parent irq
  nomadik-gpio: convert to platform driver
  ux500: add gpio support

 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-nomadik/Kconfig                      |    1 +
 arch/arm/mach-nomadik/Makefile                     |    2 +-
 arch/arm/mach-nomadik/cpu-8815.c                   |   83 ++++++++++--------
 arch/arm/mach-nomadik/include/mach/gpio.h          |   67 +--------------
 arch/arm/mach-ux500/Kconfig                        |    1 +
 arch/arm/mach-ux500/cpu-u8500.c                    |   82 +++++++++++++++++-
 arch/arm/mach-ux500/include/mach/gpio.h            |   12 +++
 arch/arm/mach-ux500/include/mach/hardware.h        |   12 +++
 arch/arm/mach-ux500/include/mach/irqs.h            |    8 ++-
 arch/arm/plat-nomadik/Kconfig                      |    5 +
 arch/arm/plat-nomadik/Makefile                     |    1 +
 arch/arm/{mach-nomadik => plat-nomadik}/gpio.c     |   93 ++++++++++++--------
 .../mach => plat-nomadik/include/plat}/gpio.h      |    7 +-
 14 files changed, 228 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/gpio.h
 rename arch/arm/{mach-nomadik => plat-nomadik}/gpio.c (86%)
 copy arch/arm/{mach-nomadik/include/mach => plat-nomadik/include/plat}/gpio.h (95%)
