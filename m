From: stelford@cadence.com (Scott Telford)
Date: Thu, 9 Aug 2018 11:30:28 +0100
Subject: [PATCH v4 0/2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
Message-ID: <1533810630-17673-1-git-send-email-stelford@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add preliminary support for the Cadence "Torrent" SD0801
PHY used with the Cadence MHDP DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

v4:
* Comment formatting
* Describe "num_lanes" and "max_bit_rate" properties as optional in
  dt-bindings documentation

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

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |  30 ++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |  10 +
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-dp.c               | 541 +++++++++++++++++++++
 6 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c

-- 
2.2.2
