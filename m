From: joel@jms.id.au (Joel Stanley)
Date: Thu, 14 Apr 2016 19:17:40 +0930
Subject: [PATCH 0/9] Aspeed AST2400 BMC support
Message-ID: <1460627269-21721-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello!

These patches add basic support for the Aspeed AST2400 SoC, a popular BMC
device that is also the target for our OpenBMC[1] efforts.

This series have been boot tested on a Palmetto; an OpenPower dev board that
uses the ast2400 as it's BMC, as well as Qemu (-M palmetto-bmc on 2.6-rc1).

Cheers,

Joel

[1] https://lwn.net/Articles/683320/


Benjamin Herrenschmidt (1):
  irqchip: Add irq controller for Aspeed

Joel Stanley (8):
  doc/devicetree: Add Aspeed and Tyan to vendor-prefixes
  doc/devicetree: Add Aspeed VIC bindings
  doc/devicetree: Add Aspeed clock bindings
  clocksource/moxart: Generalise timer for use on other socs
  drivers/clk: Add Aspeed clock driver
  arm/dts: Add aspeed device trees
  arm: Add Aspeed AST2400 machine
  arm/configs: Add aspeed defconfig

 .../devicetree/bindings/clock/aspeed-clock.txt     |  44 ++++
 .../interrupt-controller/aspeed,ast2400-vic.txt    |  24 +++
 .../bindings/timer/moxa,moxart-timer.txt           |   4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  21 ++
 arch/arm/boot/dts/ast2400.dtsi                     | 152 +++++++++++++
 arch/arm/configs/aspeed_defconfig                  |  86 ++++++++
 arch/arm/mach-aspeed/Kconfig                       |  19 ++
 arch/arm/mach-aspeed/Makefile                      |   3 +
 arch/arm/mach-aspeed/aspeed.c                      |  80 +++++++
 arch/arm/mach-aspeed/ast2400.h                     | 117 ++++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-aspeed.c                           | 106 +++++++++
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   2 +-
 drivers/clocksource/moxart_timer.c                 |  90 ++++++--
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-aspeed-vic.c                   | 238 +++++++++++++++++++++
 22 files changed, 987 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/aspeed-clock.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
 create mode 100644 arch/arm/boot/dts/ast2400.dtsi
 create mode 100644 arch/arm/configs/aspeed_defconfig
 create mode 100644 arch/arm/mach-aspeed/Kconfig
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/aspeed.c
 create mode 100644 arch/arm/mach-aspeed/ast2400.h
 create mode 100644 drivers/clk/clk-aspeed.c
 create mode 100644 drivers/irqchip/irq-aspeed-vic.c

-- 
2.7.4
