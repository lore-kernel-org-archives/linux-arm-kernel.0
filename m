From: andrew@lunn.ch (Andrew Lunn)
Date: Thu,  5 Dec 2013 17:50:59 +0100
Subject: [PATCH v2 0/4] PHY driver for Marvell SATA
Message-ID: <1386262263-18956-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This second version addresses most of the points raised during review.

What has not been changed is the phy-names property. This is awaiting
feedback on my comment that the naming follows how clocks are named in
the driver & DT binding. For this reason i've also not added the
Ack-by: received in the review comments.

Andrew Lunn (4):
  Phy: DT binding documentation for Marvell MVEBU SATA phy.
  Phy: Add a PHY driver for Marvell MVEBU SATA PHY.
  SATA: MV: Add support for the optional PHYs
  Phy: Add DT nodes on kirkwood and Dove for the SATA PHY

 Documentation/devicetree/bindings/ata/marvell.txt  |   6 +
 .../devicetree/bindings/phy/phy-mvebu.txt          |  22 ++++
 arch/arm/boot/dts/dove.dtsi                        |  11 ++
 arch/arm/boot/dts/kirkwood-6281.dtsi               |   2 +
 arch/arm/boot/dts/kirkwood-6282.dtsi               |   2 +
 arch/arm/boot/dts/kirkwood.dtsi                    |  18 +++
 drivers/ata/sata_mv.c                              |  19 +++
 drivers/phy/Kconfig                                |   6 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-mvebu-sata.c                       | 137 +++++++++++++++++++++
 10 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu.txt
 create mode 100644 drivers/phy/phy-mvebu-sata.c

-- 
1.8.5
