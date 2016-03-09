From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  9 Mar 2016 11:24:02 +0100
Subject: [PATCH v2 00/18] Add Initial support for PLX Technology OX810SE
In-Reply-To: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds initial support (IRQ, Timer, GPIO, Reset, Serial, Clocks) for
the PLX Technology OX810SE used in the well-known Western Digital My Book
World Edition Network Attached Storage device.

Extended support for SATA, DMA and Ethernet will come in further patches.

Upstream support for following devices like the OX820SE is welcome !

v2 changes :
- switch all compatible string to oxsemi,ox820se
- add oxsemi to prefixes
- switch to versatile-fpga interrupt controller with new compatible
- switch to sp804 timer with new timer width property
- cleanup of mach-oxnas (removal of generic oxnas.c)
- cleanup of standard clock to a platform driver

v1 : http://lkml.kernel.org/r/1457005210-18485-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (18):
  clocksource: sp804: Add support for non-32bit width counter
  dt-bindings: timer: sp804: add timer-width property
  irqchip: versatile-fpga: add new arm,rps-irq compatible
  dt-bindings: irq: arm,versatile-fpga: add arm,rps-irq compatible
    string
  dt-bindings: vendor-prefixes: Add PLX Technology
  dt-bindings: Add Oxford Semiconductors to vendor prefixes
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
 .../devicetree/bindings/clock/plxtech,stdclk.txt   |   35 +
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   27 +
 .../arm,versatile-fpga-irq.txt                     |    2 +-
 .../bindings/pinctrl/plxtech,pinctrl.txt           |  100 ++
 .../devicetree/bindings/reset/plxtech,reset.txt    |   58 +
 .../devicetree/bindings/timer/arm,sp804.txt        |    2 +
 .../devicetree/bindings/vendor-prefixes.txt        |    5 +-
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/ox810se.dtsi                     |  273 ++++
 arch/arm/boot/dts/wd-mbwe.dts                      |  112 ++
 arch/arm/mach-oxnas/Kconfig                        |   25 +
 arch/arm/mach-oxnas/Makefile                       |    1 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-oxnas.c                            |  202 +++
 drivers/clocksource/timer-sp804.c                  |   38 +-
 drivers/irqchip/irq-versatile-fpga.c               |    1 +
 drivers/pinctrl/Kconfig                            |    9 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-oxnas.c                    | 1392 ++++++++++++++++++++
 drivers/reset/Kconfig                              |    3 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-oxnas.c                        |  136 ++
 include/clocksource/timer-sp804.h                  |   11 +-
 27 files changed, 2437 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/clock/plxtech,stdclk.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/plxtech,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/plxtech,reset.txt
 create mode 100644 arch/arm/boot/dts/ox810se.dtsi
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts
 create mode 100644 arch/arm/mach-oxnas/Kconfig
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 drivers/clk/clk-oxnas.c
 create mode 100644 drivers/pinctrl/pinctrl-oxnas.c
 create mode 100644 drivers/reset/reset-oxnas.c

-- 
1.9.1
