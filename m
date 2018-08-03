From: stelford@cadence.com (Scott Telford)
Date: Fri, 3 Aug 2018 16:08:29 +0100
Subject: [PATCH v3 0/2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
In-Reply-To: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
References: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
Message-ID: <1533308911-17286-1-git-send-email-stelford@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add preliminary support for the Cadence "Torrent" SD0801
PHY used with the Cadence MHDP DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

v3:
* Split devicetree bindings documentation into separate commit
* Merged phy-cadence-dp.h into phy-cadence-dp.c
* Moved probe function to end of file
* Minor refactoring of cdns_dp_phy_pma_lane_cfg()
* Fixed SPDX comment format

v2:
* Fixed Linux/um build 

Scott Telford (2):
  dt-bindings: phy: Document Cadence MHDP DisplayPort PHY bindings
  phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |  28 ++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |  10 +
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-dp.c               | 538 +++++++++++++++++++++
 6 files changed, 579 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c

-- 
2.2.2
