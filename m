From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Mar 2016 12:39:53 +0100
Subject: [PATCH 00/17] Add Initial support for PLX Technology OX810SE
Message-ID: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds initial support (IRQ, Timer, GPIO, Reset, Serial, Clocks) for
the PLX Technology OX810SE used in the well-known Western Digital My Book
World Edition Network Attached Storage device.

Extended support for SATA, DMA and Ethernet will come in further patches.

Upstream support for following devices like the OX820SE is welcome !

Neil Armstrong (17):
  dt-bindings: vendor-prefixes: Add PLX Technology
  irqchip: Add PLX Technology RPS IRQ Controller
  dt-bindings: Add PLX Technology RPS IRQ Controller bindings
  clocksource: Add PLX Technology RPS Timer
  dt-bindings: Add PLX Technology RPS Timer bindings
  reset: Add PLX Technology Reset Controller driver
  dt-bindings: Add PLX Technology Reset Controller bindings
  clk: Add PLX Technology OXNAS Standard Clocks
  dt-bindings: Add PLX Technology OXNAS Standard Clocks bindings
  pinctrl: Add PLX Technology OXNAS pinctrl and gpio driver
  dt-bindings: Add PLX Technology OXNAS pinctrl and gpio bindings
  arm: Add new mach-oxnas
  arm: Add build support for mach-oxnas
  arm: boot: dts: Add PLX Technology OX810SE dtsi
  dt-bindings: Add OXNAS bindings
  dt-bindings: Add Western Digital to vendor prefixes
  arm: boot: dts: Add Western Digital My Book World Edition device tree

 Documentation/devicetree/bindings/arm/oxnas.txt    |    9 +
 .../devicetree/bindings/clock/plxtech,stdclk.txt   |   24 +
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   27 +
 .../interrupt-controller/plxtech,rps-irq.txt       |   17 +
 .../bindings/pinctrl/plxtech,pinctrl.txt           |  100 ++
 .../devicetree/bindings/reset/plxtech,reset.txt    |   25 +
 .../bindings/timer/plxtech,rps-timer.txt           |   17 +
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/ox810se.dtsi                     |  279 ++++
 arch/arm/boot/dts/wd-mbwe.dts                      |  106 ++
 arch/arm/mach-oxnas/Kconfig                        |   24 +
 arch/arm/mach-oxnas/Makefile                       |    1 +
 arch/arm/mach-oxnas/oxnas.c                        |   34 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-oxnas.c                            |  159 +++
 drivers/clocksource/Kconfig                        |    6 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/timer-rps.c                    |  249 ++++
 drivers/irqchip/Kconfig                            |    5 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-rps.c                          |  128 ++
 drivers/pinctrl/Kconfig                            |    9 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-oxnas.c                    | 1393 ++++++++++++++++++++
 drivers/reset/Kconfig                              |    4 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-oxnas.c                        |  149 +++
 31 files changed, 2783 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/clock/plxtech,stdclk.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/plxtech,rps-irq.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/plxtech,reset.txt
 create mode 100644 Documentation/devicetree/bindings/timer/plxtech,rps-timer.txt
 create mode 100644 arch/arm/boot/dts/ox810se.dtsi
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts
 create mode 100644 arch/arm/mach-oxnas/Kconfig
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/oxnas.c
 create mode 100644 drivers/clk/clk-oxnas.c
 create mode 100644 drivers/clocksource/timer-rps.c
 create mode 100644 drivers/irqchip/irq-rps.c
 create mode 100644 drivers/pinctrl/pinctrl-oxnas.c
 create mode 100644 drivers/reset/reset-oxnas.c

-- 
1.9.1
