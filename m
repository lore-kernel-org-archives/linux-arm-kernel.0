From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:24 +1030
Subject: [PATCH v2 00/19] ARM: dts: aspeed: updates and new machines
Message-ID: <20171215062443.23059-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of device tree patches for the ASPEED BMC machines
moves all systems to use the soon to be merged clk driver, and
updates machines to use all of the drivers we have upstream.

 v2: Address review from Arnd
  - Remove NUM_CLKS from dt header
  - Send VUART patch as a fix, drop it from this series
  - Add reasoning for breaking old kernel in the 'proper clock
    references' patch

In addition it adds three new OpenBMC systems that have been developed
in the OpenBMC kernel tree over the past year: two Power9 OpenPower
systems, and a port by Google to a Quanta x86 server.

I have boot tested these on Romulus and Palmetto, as well as boot tested
all device trees in Qemu.

Please review the boards you are familiar with. I will merge these in to
the ASPEED ARM SoC tree for inclusion in 4.16.

Andrew Jeffery (1):
  ARM: dts: aspeed: Add LPC and child devices

Joel Stanley (16):
  dt-bindings: clock: Add ASPEED constants
  dt-bindings: gpio: Add ASPEED constants
  ARM: dts: aspeed: Add proper clock references
  ARM: dts: aspeed: Add MAC clocks
  ARM: dts: aspeed: Add watchdog clocks
  ARM: dts: aspeed: Add flash controller clocks
  ARM: dts: aspeed: Add clock phandle to GPIO
  ARM: dts: aspeed: Add PWM and tachometer node
  ARM: dts: aspeed: Add LPC Snoop device
  ARM: dts: aspeed: Remove skeleton.dtsi
  ARM: dts: aspeed: Update license headers
  ARM: dts: Add OpenBMC flash layout
  ARM: dts: aspeed: Sort ASPEED entries in makefile
  ARM: dts: aspeed: Add Witherspoon BMC machine
  ARM: dts: aspeed-romulus: Update Romulus system
  ARM: dts: aspeed-plametto: Add flash layout

Rick Altherr (1):
  ARM: dts: aspeed: Add Qanta Q71L BMC machine

Xo Wang (1):
  ARM: dts: aspeed: Add Ingrasys Zaius BMC machine

 arch/arm/boot/dts/Makefile                       |   8 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts         |   2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts    |   3 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts     | 155 ++++++-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 547 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts       | 427 ++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts     | 458 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                 | 164 ++++---
 arch/arm/boot/dts/aspeed-g5.dtsi                 | 155 ++++---
 arch/arm/boot/dts/openbmc-flash-layout.dtsi      |  32 ++
 include/dt-bindings/clock/aspeed-clock.h         |  52 +++
 include/dt-bindings/gpio/aspeed-gpio.h           |  49 ++
 12 files changed, 1906 insertions(+), 146 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout.dtsi
 create mode 100644 include/dt-bindings/clock/aspeed-clock.h
 create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h

-- 
2.14.1
