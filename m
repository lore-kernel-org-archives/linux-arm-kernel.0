From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Tue, 28 Jul 2015 15:12:10 -0700
Subject: [PATCH v2 0/3] Add MDIO support to ThunderX NIC driver
Message-ID: <1438121533-21528-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch series adds MDIO support to ThunderX NIC driver by making use
of existing mdio-octeon driver. In the process modified the mdio-octeon
driver to work on both Octeon and ThunderX platforms.

* From v1:
  - Removed default selection in Kconfig for MDIO_OCTEON
  - Replace uint64 with u64 as suggested by David Daney

Radha Mohan Chintakuntla (3):
  net: mdio-octeon: Modify driver to work on both ThunderX and Octeon
  net: mdio-octeon: Fix octeon_mdiobus_probe function for return values
  net: thunderx: Select CONFIG_MDIO_OCTEON for ThunderX NIC

 drivers/net/ethernet/cavium/Kconfig |    2 +
 drivers/net/phy/Kconfig             |   10 ++--
 drivers/net/phy/mdio-octeon.c       |  136 +++++++++++++++++++++++++++++------
 3 files changed, 122 insertions(+), 26 deletions(-)
