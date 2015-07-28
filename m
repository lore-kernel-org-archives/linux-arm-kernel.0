From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon, 27 Jul 2015 19:14:40 -0700
Subject: [PATCH 0/3] Add MDIO support to ThunderX NIC driver
Message-ID: <1438049683-10630-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch series adds MDIO support to ThunderX NIC driver by making use
of existing mdio-octeon driver. In the process modified the mdio-octeon
driver to work on both Octeon and ThunderX platforms.

Radha Mohan Chintakuntla (3):
  net: mdio-octeon: Modify driver to work on both ThunderX and Octeon
  net: mdio-octeon: Fix octeon_mdiobus_probe function for return values
  net: thunderx: Select CONFIG_MDIO_OCTEON for ThunderX NIC

 drivers/net/ethernet/cavium/Kconfig |    2 +
 drivers/net/phy/Kconfig             |    9 ++-
 drivers/net/phy/mdio-octeon.c       |  136 +++++++++++++++++++++++++++++------
 3 files changed, 122 insertions(+), 25 deletions(-)
