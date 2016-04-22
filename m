From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Apr 2016 15:38:29 -0700
Subject: [GIT PULL] omap device tree changes for v4.7 merge window, part 1
Message-ID: <20160422223829.GO5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/dt-part1

for you to fetch changes up to a4240d3af6771339c3557afe261a8a89573980a9:

  ARM: dts: Add support for dra72-evm rev C (SR2.0) (2016-04-14 13:43:10 -0700)

----------------------------------------------------------------
First set of device tree changes for omaps for v4.7 merge window:

- Two sets of name and unit address check fixes for dts files.

- DMA, McASP, and timer and regulator related dts changes for dra7

- Add more devices for Nokia N9/N950

- Initial support for am335x ICEv2

- Initial support for am572x-IDK

- Pinctrl changes for am335x-baltos-ir5221

- Initial support for Amazon Kindle Fire (first generation)

- A series of changes to add GPIO controller support for the
  GPMC driver. The driver changes will be merged separately.

- Support for am43xx clkout1

- Pinctrl and RTC changes for am335x-chili

- Add support for dra72-evm rev C (SR2.0)

----------------------------------------------------------------
Ben Hutchings (1):
      ARM: dts: dra7xx: Fix compatible string for PCF8575 chip

Filip Matijevi? (2):
      ARM: dts: N9/N950: Add support for 1GHz CPU clock
      ARM: dts: N9/N950: Add support for accelerometer

Franklin S Cooper Jr (1):
      ARM: dts: da850/am4372/am33xx: Use generic node name for ehrpwm

Javier Martinez Canillas (5):
      ARM: dts: omap: add missing unit name to pbias regulator nodes
      ARM: dts: n8x0: remove unneeded unit name for i2c node
      ARM: dts: omap3: add missing unit name to PMU node
      ARM: dts: omap: remove unneeded unit name for sound nodes
      ARM: dts: omap: add missing unit names to bandgap nodes

Lokesh Vutla (1):
      ARM: dts: am335x: Add initial support for ICEv2 board

Marcin Niestroj (3):
      ARM: dts: am335x-chili*: Move uart0 description from SOM to board
      ARM: dts: am335x-chili*: Move Ethernet MAC description from SOM to board
      ARM: dts: am335x-chilisom: Enable poweroff PMIC sequence using RTC signal

Misael Lopez Cruz (1):
      ARM: dts: dra7: Use eDMA and add DAT port address for McASP3

Nishanth Menon (2):
      ARM: dts: dra7-evm: Add missing regulators
      ARM: dts: Add support for dra72-evm rev C (SR2.0)

Paul Kocialkowski (5):
      devicetree: bindings: Add vendor prefix for Amazon.com, Inc.
      ARM: dts: Amazon Kindle Fire (first generation) codename kc1 basic support
      ARM: dts: omap4-kc1: USB OTG support
      ARM: dts: omap4-kc1: LEDs support
      ARM: dts: omap4-kc1: Power off support

Peter Ujfalusi (8):
      ARM: dts: dra7: Move the sDMA crossbar node under l4_cfg/scm
      ARM: dts: dra7: Enable eDMA
      ARM: dts: dra7-evm: Enable AFIFO use for McASP3
      ARM: dts: dra72-evm: Enable AFIFO use for McASP3
      ARM: dts: am57xx-beagle-x15: Move clkout2 source selection to codec node
      ARM: dts: am57xx-beagle-x15: Enable AFIFO use for McASP3
      ARM: dts: dra7xx: Correct mcasp8_ahclkx_mux name
      ARM: dts: dra7: Add nodes for McASP1/2/4/5/6/7/8

Roger Quadros (14):
      ARM: dts: dra7-evm: Fix comment about NAND configuration
      ARM: dts: omap24xx: Enable gpio and interrupt controller for GPMC
      ARM: dts: omap4: Enable gpio and interrupt controller for GPMC
      ARM: dts: omap5: Enable gpio and interrupt controller for GPMC
      ARM: dts: dra7: Enable gpio controller for GPMC
      ARM: dts: am335x: Enable gpio controller for GPMC
      ARM: dts: am4372: Enable gpio controller for GPMC
      ARM: dts: omap3: Enable gpio controller for GPMC
      ARM: dts: dm814x: Enable gpio controller for GPMC
      ARM: dts: dm816x: Enable gpio controller for GPMC
      ARM: dts: dra7x-evm: Provide NAND ready pin
      ARM: dts: am437x: Provide NAND ready pin
      ARM: dts: am335x: Provide NAND ready pin
      ARM: dts: omap3-beagle: Provide NAND ready pin

Schuyler Patton (1):
      ARM: dts: AM572x-IDK Initial Support

Sebastian Reichel (5):
      ARM: dts: n9/n950: regulator configuration
      ARM: dts: OMAP3-N950: Add Keypad Matrix
      ARM: dts: OMAP3-N950: Add Vibrator
      ARM: dts: Enable N950 keyboard sleep leds by default
      ARM: dts: OMAP3-N950: Add Keypad Slide Switch

Suman Anna (2):
      ARM: dts: DRA7: Enable Timers 13 through 16
      ARM: dts: DRA7: Add timer12 node

Tero Kristo (9):
      ARM: dts: omap3: fix clock node definitions to avoid build warnings
      ARM: dts: omap2: fix clock node definitions to avoid build warnings
      ARM: dts: omap4: fix clock node definitions to avoid build warnings
      ARM: dts: am33xx: fix clock node definitions to avoid build warnings
      ARM: dts: am43xx: fix clock node definitions to avoid build warnings
      ARM: dts: dm81x: fix clock node definitions to avoid build warnings
      ARM: dts: dra7: fix clock node definitions to avoid build warnings
      ARM: dts: omap5: fix clock node definitions to avoid build warnings
      ARM: dts: am43xx: add support for clkout1 clock

Yegor Yefremov (1):
      ARM: dts: am335x-baltos-ir5221: use dedicated RTS/CTS signals

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |  13 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            |  75 ++
 arch/arm/boot/dts/am335x-chilisom.dtsi             |  77 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |   1 +
 arch/arm/boot/dts/am335x-evm.dts                   |   1 +
 arch/arm/boot/dts/am335x-icev2.dts                 | 306 ++++++++
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   1 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   1 +
 arch/arm/boot/dts/am335x-shc.dts                   |   2 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi               |  90 +--
 arch/arm/boot/dts/am33xx.dtsi                      |   8 +-
 arch/arm/boot/dts/am35xx-clocks.dtsi               |  20 +-
 arch/arm/boot/dts/am4372.dtsi                      |  14 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   3 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   3 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               | 170 +++--
 arch/arm/boot/dts/am572x-idk.dts                   |  85 +++
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   9 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           | 302 ++++++++
 arch/arm/boot/dts/da850.dtsi                       |   4 +-
 arch/arm/boot/dts/dm814x-clocks.dtsi               |  10 +-
 arch/arm/boot/dts/dm814x.dtsi                      |   2 +
 arch/arm/boot/dts/dm816x-clocks.dtsi               |  42 +-
 arch/arm/boot/dts/dm816x.dtsi                      |   2 +
 arch/arm/boot/dts/dra7-evm.dts                     |  39 +-
 arch/arm/boot/dts/dra7.dtsi                        | 200 ++++-
 arch/arm/boot/dts/dra72-evm-common.dtsi            | 833 ++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm-revc.dts               |  73 ++
 arch/arm/boot/dts/dra72-evm.dts                    | 835 +--------------------
 arch/arm/boot/dts/dra7xx-clocks.dtsi               | 376 +++++-----
 arch/arm/boot/dts/omap2420-clocks.dtsi             |  38 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   4 +
 arch/arm/boot/dts/omap2430-clocks.dtsi             |  58 +-
 arch/arm/boot/dts/omap2430.dtsi                    |   6 +-
 arch/arm/boot/dts/omap24xx-clocks.dtsi             | 228 +++---
 arch/arm/boot/dts/omap3-beagle.dts                 |   1 +
 arch/arm/boot/dts/omap3-n9.dts                     |  14 +
 arch/arm/boot/dts/omap3-n950-n9.dtsi               | 151 ++++
 arch/arm/boot/dts/omap3-n950.dts                   |  99 +++
 arch/arm/boot/dts/omap3.dtsi                       |   6 +-
 arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  30 +-
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi    |  44 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |   2 +-
 .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  32 +-
 arch/arm/boot/dts/omap36xx-clocks.dtsi             |  14 +-
 .../boot/dts/omap36xx-omap3430es2plus-clocks.dtsi  |  14 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |   2 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             | 276 +++----
 arch/arm/boot/dts/omap4-kc1.dts                    | 182 +++++
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 +-
 arch/arm/boot/dts/omap4.dtsi                       |   6 +-
 arch/arm/boot/dts/omap443x-clocks.dtsi             |   2 +-
 arch/arm/boot/dts/omap443x.dtsi                    |   2 +-
 arch/arm/boot/dts/omap4460.dtsi                    |   2 +-
 arch/arm/boot/dts/omap446x-clocks.dtsi             |   4 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi             | 316 ++++----
 arch/arm/boot/dts/omap5.dtsi                       |   6 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi             | 260 +++----
 drivers/clk/ti/clk-7xx.c                           |   2 +-
 64 files changed, 3478 insertions(+), 1939 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-icev2.dts
 create mode 100644 arch/arm/boot/dts/am572x-idk.dts
 create mode 100644 arch/arm/boot/dts/am57xx-idk-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra72-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra72-evm-revc.dts
 create mode 100644 arch/arm/boot/dts/omap4-kc1.dts
