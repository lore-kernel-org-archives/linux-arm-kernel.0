From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 14 Mar 2016 17:30:36 -0700
Subject: [PATCH 0/3] net/phy: Fixes for Cavium Thunder MDIO code.
Message-ID: <1458001839-15993-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Previous patch set:
commit 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
commit 1eefee901fca ("phy: mdio-octeon: Refactor into two files/modules")
commit 379d7ac7ca31 ("phy: mdio-thunder: Add driver for Cavium Thunder SoC MDIO buses.")

Had several problems.  We try to fix them here.


David Daney (3):
  phy: mdio-cavium: Add missing MODULE_* annotations.
  net: cavium: For Kconfig THUNDER_NIC_BGX, select MDIO_THUNDER.
  net: thunderx: Don't leak phy device references on -EPROBE_DEFER
    condition.

 drivers/net/ethernet/cavium/Kconfig               |  2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 26 +++++++++++++++++------
 drivers/net/phy/mdio-cavium.c                     |  4 ++++
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.7.11.7
