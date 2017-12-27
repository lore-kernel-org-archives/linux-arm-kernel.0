From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 Dec 2017 23:14:40 +0100
Subject: [PATCH net-next 0/6] net: mvpp2: 1000BaseX and 2000BaseX support
Message-ID: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series adds 1000BaseX and 2500BaseX support to the Marvell PPv2
driver. In order to use it, the 2.5 SGMII mode is added in the Marvell
common PHY driver (cp110-comphy).

Thanks to theses patches the fourth network interface can be used on the
mcbin, and two patches are attached: one to describe the interface in
the mcbin device tree, and another one adding Ethernet aliases now that
the four interfaces are described.

This was tested on a mcbin.

Patches 1 and 2 should go through the PHY tree, patches 3 and 4 through
the net-next tree and patches 5 and 6 through the mvebu one.

Please note the two mvpp2 patches do not conflict with the ACPI series
Marcin sent a few days ago, and the two series can be processed in
parallel. (Marcin is aware of me sending this series).

Thanks!
Antoine

Antoine Tenart (5):
  phy: add 2.5G SGMII mode to the phy_mode enum
  phy: cp110-comphy: 2.5G SGMII mode
  net: mvpp2: 1000baseX support
  net: mvpp2: 2500baseX support
  arm64: dts: marvell: mcbin: enable the fourth network interface

Yan Markman (1):
  arm64: dts: marvell: add Ethernet aliases

 arch/arm64/boot/dts/marvell/armada-7040-db.dts    |  6 ++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts    |  7 +++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 15 +++++
 drivers/net/ethernet/marvell/mvpp2.c              | 67 +++++++++++++++++++----
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c      | 17 +++++-
 include/linux/phy/phy.h                           |  1 +
 6 files changed, 100 insertions(+), 13 deletions(-)

-- 
2.14.3
