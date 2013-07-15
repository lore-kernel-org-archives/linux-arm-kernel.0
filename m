From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jul 2013 17:34:07 +0200
Subject: [RFC PATCH 0/3] Add DT support for fixed PHYs
Message-ID: <1373902450-11857-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Following the discussion of last week with Florian Fainelli and Grant
Likely [1], this patch set introduces DT-based support for fixed PHYs
through an additional OF API, and uses it in the context of the
Marvell mvneta network driver.

Grant, Rob, your opinions as DT maintainers are welcome. Thanks!

Thomas

[1] http://www.spinics.net/lists/netdev/msg242766.html
    http://www.spinics.net/lists/netdev/msg243192.html

Thomas Petazzoni (3):
  of: provide a binding for the 'fixed-link' property
  net: phy: call mdiobus_scan() after adding a fixed PHY
  net: mvneta: add support for fixed links

 .../devicetree/bindings/net/fixed-link.txt         | 26 ++++++++++++++++
 .../bindings/net/marvell-armada-370-neta.txt       | 24 +++++++++++++--
 drivers/net/ethernet/marvell/mvneta.c              | 18 ++++++++---
 drivers/net/phy/fixed.c                            |  2 ++
 drivers/of/of_mdio.c                               | 36 +++++++++++++++++++---
 include/linux/of_mdio.h                            | 10 ++++++
 6 files changed, 104 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fixed-link.txt

-- 
1.8.1.2
