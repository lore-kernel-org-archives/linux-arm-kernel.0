From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 10 Jan 2018 16:58:04 +0100
Subject: [PATCH net-next v4 0/4] net: mvpp2: 1000BaseX and 2500BaseX support
Message-ID: <20180110155808.3484-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series adds 1000BaseX and 2500BaseX support to the Marvell PPv2
driver. In order to use it, the 2.5 SGMII mode is added in the Marvell
common PHY driver (cp110-comphy).

This was tested on a mcbin.

All patches should probably go through net-next as patch 4/4 depends on
patch 1/4 to build and work.

Please note the two mvpp2 patches do not conflict with the ACPI series
v2 Marcin sent a few days ago, and the two series can be processed in
parallel. (Marcin is aware of me sending this series).

Thanks!
Antoine

Since v3:
  - Stopped setting the MII_SPEED bit in the GMAC AN register, as the
    GMII_SPEED bit takes over anyway.
  - Added Andrew's Reviewed-by on patch 4/4.

Since v2:
  - Added a comment before mvpp22_comphy_init() about the different PHY modes
    used and why they differ between the PPv2 driver and the COMPHY one.

Since v1:
  - s/PHY_MODE_SGMII_2_5G/PHY_MODE_2500SGMII/
  - Fixed a build error in 'net: mvpp2: 1000baseX support' (which was solved in
    the 2500baseX support one, but the bisection was broken).
  - Removed the dt patches, as the fourth network interface on the mcbin also
    needs PHYLINK support in the PPv2 driver to be correctly supported.

Antoine Tenart (4):
  phy: add 2.5G SGMII mode to the phy_mode enum
  phy: cp110-comphy: 2.5G SGMII mode
  net: mvpp2: 1000baseX support
  net: mvpp2: 2500baseX support

 drivers/net/ethernet/marvell/mvpp2.c         | 74 ++++++++++++++++++++++++----
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 17 +++++--
 include/linux/phy/phy.h                      |  1 +
 3 files changed, 79 insertions(+), 13 deletions(-)

-- 
2.14.3
