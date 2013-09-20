From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:17:06 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring take 2
Message-ID: <1379708226-7802-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of the IOP GPIO refactoring, this time
I took some extra care to be sure I moved all the IOP32x boards
to instantiate their platform devices properly, as noted
by Aaro.

Also available as a branch:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git iop-cleanup

Testing and ACKing appreciated.

Linus Walleij (8):
  ARM: plat-iop: move the GPIO driver to drivers/gpio
  ARM: iop32x: request and issue reset using gpio
  ARM: iop32x: read N2100 power key using gpiolib
  gpio: decouple the IOP GPIO driver from platform
  ARM: plat-iop: remove custom complex GPIO implementation
  ARM: plat-iop: instantiate GPIO from platform device
  gpio: iop: use readl/writel accessors
  ARM: plat-iop: pass physical base for GPIO

 arch/arm/Kconfig                            |   4 +-
 arch/arm/include/asm/hardware/iop3xx-gpio.h |  75 ----------------
 arch/arm/include/asm/hardware/iop3xx.h      |  12 ---
 arch/arm/mach-iop32x/em7210.c               |   2 +
 arch/arm/mach-iop32x/glantank.c             |   2 +
 arch/arm/mach-iop32x/gpio-iop32x.h          |  10 +++
 arch/arm/mach-iop32x/include/mach/gpio.h    |   6 --
 arch/arm/mach-iop32x/include/mach/iop32x.h  |   1 -
 arch/arm/mach-iop32x/iq31244.c              |   2 +
 arch/arm/mach-iop32x/iq80321.c              |   2 +
 arch/arm/mach-iop32x/n2100.c                |  47 ++++++++--
 arch/arm/mach-iop33x/include/mach/gpio.h    |   6 --
 arch/arm/mach-iop33x/include/mach/iop33x.h  |   1 -
 arch/arm/mach-iop33x/iq80331.c              |   7 ++
 arch/arm/mach-iop33x/iq80332.c              |   7 ++
 arch/arm/plat-iop/Makefile                  |   2 -
 arch/arm/plat-iop/gpio.c                    |  93 --------------------
 drivers/gpio/Kconfig                        |   9 ++
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/gpio-iop.c                     | 130 ++++++++++++++++++++++++++++
 20 files changed, 213 insertions(+), 206 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/iop3xx-gpio.h
 create mode 100644 arch/arm/mach-iop32x/gpio-iop32x.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-iop/gpio.c
 create mode 100644 drivers/gpio/gpio-iop.c

-- 
1.8.3.1
