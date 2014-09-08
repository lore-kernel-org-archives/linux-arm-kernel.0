From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 Sep 2014 13:37:59 +0200
Subject: [PATCH 0/7]  ARM RealView DeviceTree support v6
Message-ID: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've updated the RealView DeviceTree patch again.

Main changes:
- Calculate cache associativity from ePAPR definitions
- Rely on the l2c_aux_[mask|val] from the DT_MACHINE
- Add cache line size to device tree

Florian Fainelli (1):
  ARM: l2c: parse 'cache-size' and 'cache-sets' properties

Linus Walleij (6):
  leds: add a driver for syscon-based LEDs
  leds: add device tree bindings for register bit LEDs
  power: reset: driver for the Versatile syscon reboot
  soc: add driver for the ARM RealView
  ARM: l2x0: calculate associativity from ePAPR cache props
  ARM: realview: basic device tree implementation

 Documentation/devicetree/bindings/arm/arm-boards   |  65 ++++++
 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 Documentation/devicetree/bindings/arm/l2cc.txt     |   2 +
 .../devicetree/bindings/leds/register-bit-led.txt  |  99 +++++++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts          | 246 +++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                     |  13 ++
 arch/arm/mach-realview/Makefile                    |   1 +
 arch/arm/mach-realview/realview-dt.c               |  32 +++
 arch/arm/mm/cache-l2x0.c                           | 111 ++++++++++
 drivers/irqchip/irq-gic.c                          |   2 +
 drivers/leds/Kconfig                               |  10 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-syscon.c                         | 165 ++++++++++++++
 drivers/power/reset/Kconfig                        |   9 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/arm-versatile-reboot.c         | 111 ++++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/versatile/Kconfig                      |  10 +
 drivers/soc/versatile/Makefile                     |   1 +
 drivers/soc/versatile/soc-realview.c               | 144 ++++++++++++
 22 files changed, 1027 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/register-bit-led.txt
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c
 create mode 100644 drivers/leds/leds-syscon.c
 create mode 100644 drivers/power/reset/arm-versatile-reboot.c
 create mode 100644 drivers/soc/versatile/Kconfig
 create mode 100644 drivers/soc/versatile/Makefile
 create mode 100644 drivers/soc/versatile/soc-realview.c

-- 
1.9.3
