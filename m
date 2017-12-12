From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 12 Dec 2017 09:29:46 +0000
Subject: [PATCH 1/2] net: dsa: allow XAUI phy interface mode
Message-ID: <E1eOgsk-0001AU-5z@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

XGMII is a 32-bit bus plus two clock signals per direction.  XAUI is
four serial lanes per direction.  The 88e6190 supports XAUI but not
XGMII as it doesn't have enough pins.  The same is true of 88e6176.

Match on PHY_INTERFACE_MODE_XAUI for the XAUI port type, but keep
accepting XGMII for backwards compatibility.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index a7801f6668a5..6315774d72b3 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -338,6 +338,7 @@ int mv88e6390x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 		cmode = MV88E6XXX_PORT_STS_CMODE_2500BASEX;
 		break;
 	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_XAUI:
 		cmode = MV88E6XXX_PORT_STS_CMODE_XAUI;
 		break;
 	case PHY_INTERFACE_MODE_RXAUI:
-- 
2.7.4
