From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:40:14 +0100
Subject: [PATCH 109/222] net:fec: increase transmit ring size
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeUI-0007KU-1K@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increasing the transmit ring size allows us to queue more packets before
needing to stop the transmit queue.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 4b92758b51b8..62fe1217b781 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -251,8 +251,8 @@ union bufdesc_u {
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
-#define TX_RING_SIZE		16	/* Must be power of two */
-#define TX_RING_MOD_MASK	15	/*   for this to work */
+#define TX_RING_SIZE		64	/* Must be power of two */
+#define TX_RING_MOD_MASK	63	/*   for this to work */
 
 #define BD_ENET_RX_INT          0x00800000
 #define BD_ENET_RX_PTP          ((ushort)0x0400)
-- 
1.8.3.1
