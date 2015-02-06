From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  6 Feb 2015 16:57:46 +0100
Subject: [PATCH 00/10] ARM: mvebu: add basic support for Armada 39x
Message-ID: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of patches add basic support for a new family of Marvell EBU
processors: the Armada 39x. They are based on Cortex-A9 (like Armada
375 and 38x) and the most important new feature is probably the
addition of 10 GbE support.

See http://www.marvell.com/embedded-processors/armada-39x/ for a basic
introduction.

Note that this web page talks about an Armada 395 and Armada 398, but
so far the technical documentation we have been given access to only
describes Armada 390 and Armada 398, so this series supports only
Armada 390 and Armada 398 so far. Support for Armada 395 might be
added in the future, once we get access to the appropriate technical
details.

Besides this, this series should be relatively straightforward:

 * Addition or update of various Device Tree binding documents

 * Addition of clock support for Armada 39x

 * Addition of pinctrl support for Armada 39x

 * Core support and Device Tree for Armada 39x, with one Armada 398
   Development Board supported

For now, the support is limited to a small subset of devices, we will
enable more and more hardware blocks in the near future.

This branch is based on mvebu/for-next, and is obviously 3.21
material. Such an early posting is done to gather early review and
feedback. I'll repost an updated series that takes into account the
initial feedback once 3.20-rc1 lands.

Thanks,

Thomas Petazzoni

Thomas Petazzoni (10):
  devicetree: bindings: add DT binding for the Marvell Armada 39x SoC
    family
  devicetree: bindings: update DT bindings for Marvell EBU clock support
  devicetree: bindings: add Device Tree bindings for Armada 39x
    pin-muxing controller
  devicetree: bindings: add new SMP enable method for Marvell Armada 39x
  clk: mvebu: extend common code to allow an optional refclk
  clk: mvebu: add Marvell Armada 39x driver
  pinctrl: mvebu: add pinctrl driver for Marvell Armada 39x
  ARM: mvebu: add core support for Armada 39x
  ARM: mvebu: add Device Tree files for Armada 39x SoC and board
  Documentation: arm: update supported Marvell EBU processors

 Documentation/arm/Marvell/README                   |   5 +
 .../devicetree/bindings/arm/armada-39x.txt         |  20 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   9 +
 .../bindings/clock/mvebu-gated-clock.txt           |  15 +-
 .../pinctrl/marvell,armada-39x-pinctrl.txt         |  78 ++++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-390.dtsi                  |  57 +++
 arch/arm/boot/dts/armada-398-db.dts                | 116 ++++++
 arch/arm/boot/dts/armada-398.dtsi                  |  60 +++
 arch/arm/boot/dts/armada-39x.dtsi                  | 372 ++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig                        |  14 +
 arch/arm/mach-mvebu/board-v7.c                     |  14 +
 arch/arm/mach-mvebu/platsmp-a9.c                   |   2 +
 drivers/clk/mvebu/Kconfig                          |   4 +
 drivers/clk/mvebu/Makefile                         |   1 +
 drivers/clk/mvebu/armada-39x.c                     | 156 ++++++++
 drivers/clk/mvebu/common.c                         |  17 +
 drivers/clk/mvebu/common.h                         |   1 +
 drivers/pinctrl/mvebu/Kconfig                      |   4 +
 drivers/pinctrl/mvebu/Makefile                     |   1 +
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c         | 432 +++++++++++++++++++++
 22 files changed, 1380 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-39x-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/armada-390.dtsi
 create mode 100644 arch/arm/boot/dts/armada-398-db.dts
 create mode 100644 arch/arm/boot/dts/armada-398.dtsi
 create mode 100644 arch/arm/boot/dts/armada-39x.dtsi
 create mode 100644 drivers/clk/mvebu/armada-39x.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-39x.c

-- 
2.1.0
