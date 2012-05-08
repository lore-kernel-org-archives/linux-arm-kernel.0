From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 May 2012 11:43:34 +0200
Subject: [PATCH 00/12] pinctrl for Ux500 and Nomadik family
Message-ID: <1336470214-23407-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the Nomadik "GPIO" driver to the pinctrl subsystem
and adds the interfaces needed to provide a pinctrl driver for
the DB8500 ASIC.

It further switches Ux500 over to using it with a combination
of hogs and runtime controls.

The ux500 portions were developed on top of the gpio and pins
branch earlier sent for integration in the ARM SoC tree.

Linus Walleij (12):
  gpio: move the Nomadik GPIO driver to pinctrl
  pinctrl: basic Nomadik pinctrl interface
  pinctrl/nomadik: break out single GPIO debug function
  pinctrl/nomadik: reuse GPIO debug function for pins
  pinctrl/nomadik: implement pin multiplexing
  pinctrl/nomadik: implement pin configuration
  pinctrl: add sleep state definition
  ARM: ux500: switch over to Nomadik pinctrl driver
  ARM: ux500: delete custom pin control system
  ARM: ux500: switch to using pinctrl for uart0
  ARM: ux500: alter MSP registration to return a device pointer
  ARM: ux500: switch MSP to using pinctrl for pins

 arch/arm/mach-ux500/Kconfig                 |    3 +
 arch/arm/mach-ux500/board-mop500-msp.c      |   85 +-
 arch/arm/mach-ux500/board-mop500-pins.c     |  855 ++++++-------
 arch/arm/mach-ux500/board-mop500.c          |   83 +-
 arch/arm/mach-ux500/board-mop500.h          |    6 +-
 arch/arm/mach-ux500/cpu-db8500.c            |    1 +
 arch/arm/mach-ux500/devices-common.h        |   12 +
 arch/arm/mach-ux500/pins.c                  |   88 --
 arch/arm/mach-ux500/pins.h                  |   46 -
 arch/arm/plat-nomadik/include/plat/pincfg.h |   13 +
 drivers/gpio/Makefile                       |    1 -
 drivers/gpio/gpio-nomadik.c                 | 1306 -------------------
 drivers/pinctrl/Kconfig                     |   10 +
 drivers/pinctrl/Makefile                    |    2 +
 drivers/pinctrl/pinctrl-nomadik-db8500.c    |  857 +++++++++++++
 drivers/pinctrl/pinctrl-nomadik.c           | 1800 +++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-nomadik.h           |   77 ++
 include/linux/pinctrl/pinctrl-state.h       |   13 +
 18 files changed, 3326 insertions(+), 1932 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pins.c
 delete mode 100644 arch/arm/mach-ux500/pins.h
 delete mode 100644 drivers/gpio/gpio-nomadik.c
 create mode 100644 drivers/pinctrl/pinctrl-nomadik-db8500.c
 create mode 100644 drivers/pinctrl/pinctrl-nomadik.c
 create mode 100644 drivers/pinctrl/pinctrl-nomadik.h

-- 
1.7.9.2
