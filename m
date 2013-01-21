From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Jan 2013 09:37:53 +0100
Subject: [PATCH] net: fec: Add support for multiple phys on mdiobus
Message-ID: <1358757475-21035-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There may be multiple phys on an mdio bus. This series adds support
for this to the fec driver. I recently had a board which has a switch
connected to the fec's mdio bus, so I had to pick the correct phy.

This series should be in line with other network drivers supporting
this (Marvell Armada for example)

Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      net: fec: refactor dt probing
      net: fec: Add support for phys from devicetree

 Documentation/devicetree/bindings/net/fsl-fec.txt |   20 ++++++
 drivers/net/ethernet/freescale/fec.c              |   77 ++++++++++++---------
 drivers/net/ethernet/freescale/fec.h              |    1 +
 3 files changed, 67 insertions(+), 31 deletions(-)
