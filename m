From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 29 Mar 2017 16:42:26 +0800
Subject: [PATCH net-next] net: mvneta: add RGMII_RXID and RGMII_TXID support
Message-ID: <20170329084226.3472-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RGMII_RXID and RGMII_TX_ID share the same GMAC CTRL setting as RGMII
or RGMII_ID.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index aebbc5399a06..7a6c65b44d7e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4099,6 +4099,8 @@ static int mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		ctrl |= MVNETA_GMAC2_PORT_RGMII;
 		break;
 	default:
-- 
2.11.0
