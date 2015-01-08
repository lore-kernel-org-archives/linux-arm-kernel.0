From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Jan 2015 15:39:36 +0100
Subject: [PATCH v3 0/7] 
Message-ID: <1420727983-23922-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This set of patches add the support for the Armada 385 AP board.

It also adds a few clean ups here and there, a few missing pin
functions needed for the board, etc.

Maxime

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

Maxime Ripard (7):
  ARM: mvebu: Rename DEBUG_LL to indicate UART index
  ARM: mvebu: Add UART1 as DEBUG_LL possible target
  ARM: mvebu: a38x: Fix node names
  pinctrl: mvebu: a38x: Add UART1 muxing options
  ARM: mvebu: A38x: Remove redundant pinctrl informations
  ARM: mvebu: Add a number of pinctrl functions
  ARM: mvebu: Add Armada 385 Access Point Development Board support

 arch/arm/Kconfig.debug                     |  35 +++++--
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/armada-380.dtsi          |   3 +-
 arch/arm/boot/dts/armada-385-db-ap.dts     | 150 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-385-db.dts        |   2 +-
 arch/arm/boot/dts/armada-385-rd.dts        |   2 +-
 arch/arm/boot/dts/armada-385.dtsi          |   3 +-
 arch/arm/boot/dts/armada-38x.dtsi          |  44 ++++++++-
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c |   6 +-
 9 files changed, 226 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-db-ap.dts

-- 
2.2.1
