From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 11 May 2017 15:29:20 +0200
Subject: [PATCH for 4.13 0/5] phy: bcm-ns-usb3: add MDIO driver
Message-ID: <20170511132925.14564-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

As explained in the commit 9200c6f177638 ("Revert "phy: Add USB3 PHY support
for Broadcom NSP SoC"") this module should be modified to use MDIO bus as
this is how PHY is really attached.

This should allow reusing this driver on NSP and any other platform with
MDIO bus and this particular PHY.

This is material for the next merge window (4.13 kernel) obviously.

Rafa? Mi?ecki (5):
  phy: bcm-ns-usb3: always wait for idle after writing to the PHY reg
  phy: bcm-ns-usb3: use pointer for PHY writing function
  phy: bcm-ns-usb3: enable MDIO in the platform specific code
  dt-bindings: phy: Modify Broadcom NS USB 3.0 PHY binding to use MDIO
  phy: bcm-ns-usb3: add MDIO driver using proper bus layer

 .../devicetree/bindings/phy/bcm-ns-usb3-phy.txt    |  27 ++-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/phy-bcm-ns-usb3.c                      | 223 +++++++++++++++------
 3 files changed, 179 insertions(+), 72 deletions(-)

-- 
2.11.0
