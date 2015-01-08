From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 11:51:37 +0100
Subject: [PATCH v2 0/8] Add Armada 385 General Purpose Development Board
 support
Message-ID: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch set adds the support for the Armada 385 GP board, this
board is pretty close to the Armada 385 RD one. It comes with a new
revision of the Armada 38x SoC (A0). Actually the SoC used here is the
Armada 388 one, which differed from the Armada 385 by allowing to use
two more SATA ports.

In this second version, I took into account the various comments from
the 1st version but also some comments addressed to the Armada 385 AP
series. The bigest changes are the removal of the regulator for the
SATA which will be part of another series, the add of a dtsi file for
the Armada 388 variant, and the add of pinctrl configuration. See the
changelog for the details.

The first 3 patches came from Maxime's series to support the AP
board. I have done this in order to have a complete series and also
because I don't expect big change in these patches.

Changelog:

v1 -> v2:
- removed the earlyprintk in the command line
- added the stdout-path for the bootloader
- added the pinctrl configuration for all the node that need it
- renamed pca9555_ into expander
- added comment about the connector
- switched the PHY address to match the hardware
- removed the nr-ports property which is specific to the mv-sata and
  not the ahci
- removed the clock-frequency property of the sdhci node
- formatted the speed-map of gpio-fan with a newline between the map
  entries
- removed the SATA regulators
- added the dtsi for the Armada 388 variant

Gregory CLEMENT (5):
  ARM: mvebu: a38x: Add more pinctrl functions
  ARM: mvebu: a38x: Add missing labels
  ARM: mvebu: Document the Device Tree binding for the Armada 388 SoC
  ARM: mvebu: Add Device Tree description of the Armada 388 SoC
  ARM: mvebu: Add Armada 385 General Purpose Development Board support

Maxime Ripard (3):
  ARM: mvebu: a38x: Fix node names
  ARM: mvebu: A38x: Remove redundant pinctrl informations
  ARM: mvebu: Add a number of pinctrl functions

 .../devicetree/bindings/arm/armada-38x.txt         |   7 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-380.dtsi                  |   3 +-
 arch/arm/boot/dts/armada-385-db.dts                |   2 +-
 arch/arm/boot/dts/armada-385-gp.dts                | 288 +++++++++++++++++++++
 arch/arm/boot/dts/armada-385-rd.dts                |   2 +-
 arch/arm/boot/dts/armada-385.dtsi                  |   3 +-
 arch/arm/boot/dts/armada-388.dtsi                  |  58 +++++
 arch/arm/boot/dts/armada-38x.dtsi                  |  93 ++++++-
 9 files changed, 447 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-gp.dts
 create mode 100644 arch/arm/boot/dts/armada-388.dtsi

-- 
1.9.1
