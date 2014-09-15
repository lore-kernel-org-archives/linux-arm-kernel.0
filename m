From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 16 Sep 2014 01:12:56 +0800
Subject: [Patch net-next 3/4] net:fec: increase DMA queue number
In-Reply-To: <1410801177-15872-1-git-send-email-Frank.Li@freescale.com>
References: <1410801177-15872-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1410801177-15872-4-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fugang Duan <B38611@freescale.com>

when enable interrupt coalesce, 8 BD is not enough.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/net/ethernet/freescale/fec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index f13e319..c61eff6 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -296,7 +296,7 @@ struct bufdesc_ex {
  * the skbuffer directly.
  */
 
-#define FEC_ENET_RX_PAGES	8
+#define FEC_ENET_RX_PAGES	256
 #define FEC_ENET_RX_FRSIZE	2048
 #define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
-- 
1.9.1
