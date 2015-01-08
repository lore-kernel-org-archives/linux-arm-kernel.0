From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 18:38:02 +0100
Subject: [PATCH v4 00/12]  Add Armada 38x GP and AP boards support
Message-ID: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches adds the support for the Armada 385 AP and GP
boards. It introduce the bindings for the Armada388 SoC variants and
also adds a few clean ups here and there, a few missing pin functions
needed for the board, etc.

It follows the v3 of the AP patch set:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/383709
and the v2 of the GP patch set:
http://www.spinics.net/lists/arm-kernel/msg389259.html.

Thanks,

Gregory

AP changelog:
Changes from v3:
  - Switched the dts license to the dual one X11/GPL

Changes from v2:
  - Removed the i2c1 bus that is not used
  - Added comments for the i2c0 and the UARTs
  - Removed the i2c clk-frequency property
  - Fixed the SPI-NOR maximum frequency
  - Fixed the phy nodes unit addresses
  - Add the /chosen/stdout-path property
  - Changed the filename to match the board compatible

Changes from v1:
  - Removed USB3 support. This required some additional patches for
    the phy and USB drivers that are not really related to this
    serie. This will be submitted as a separate one.
  - Removed earlyprintk from the default bootargs
  - Removed two unneeded ranges
  - Changed the phy pins node name to mdio
  - Moved most of the pinctrl nodes to the DTSI
  - Added a comment to mention why the phy reference clock is needed.
  - Rebased on top of 3.19-rc1

GP Changelog:
v2 -> v4:
  - fixed the indentation of the speed-map of gpio-fan
  - moved the 2ns SATA controller node in the armada388.dtsi file
  - converted the DB and RD board to the Armada 388 SoC

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
  ARM: mvebu: Add Armada 388 General Purpose Development Board support

Maxime Ripard (7):
  ARM: mvebu: Rename DEBUG_LL to indicate UART index
  ARM: mvebu: Add UART1 as DEBUG_LL possible target
  ARM: mvebu: a38x: Fix node names
  pinctrl: mvebu: a38x: Add UART1 muxing options
  ARM: mvebu: A38x: Remove redundant pinctrl informations
  ARM: mvebu: Add a number of pinctrl functions
  ARM: mvebu: Add Armada 385 Access Point Development Board support

 .../devicetree/bindings/arm/armada-38x.txt         |   7 +
 arch/arm/Kconfig.debug                             |  35 ++-
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/armada-380.dtsi                  |   3 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             | 178 +++++++++++++
 arch/arm/boot/dts/armada-385-gp.dts                | 288 +++++++++++++++++++++
 arch/arm/boot/dts/armada-385.dtsi                  |   3 +-
 .../dts/{armada-385-db.dts => armada-388-db.dts}   |   9 +-
 .../dts/{armada-385-rd.dts => armada-388-rd.dts}   |   9 +-
 arch/arm/boot/dts/armada-388.dtsi                  |  70 +++++
 arch/arm/boot/dts/armada-38x.dtsi                  |  93 ++++++-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c         |   6 +-
 12 files changed, 678 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-db-ap.dts
 create mode 100644 arch/arm/boot/dts/armada-385-gp.dts
 rename arch/arm/boot/dts/{armada-385-db.dts => armada-388-db.dts} (92%)
 rename arch/arm/boot/dts/{armada-385-rd.dts => armada-388-rd.dts} (88%)
 create mode 100644 arch/arm/boot/dts/armada-388.dtsi

-- 
1.9.1
