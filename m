From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:48 -0700
Subject: [PATCH net-next V3 02/16] net: fec: remove unused interrupt
 FEC_ENET_TS_TIMER
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-3-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FEC_ENET_TS_TIMER is not checked in the interrupt routine
so there is no need to enable it.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: New patch

Frank Li said "TS_TIMER should never be triggered."
when discussing another patch.
---
 drivers/net/ethernet/freescale/fec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 195122e..6dd0ba8 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -374,8 +374,8 @@ struct bufdesc_ex {
 #define FEC_ENET_TS_AVAIL       ((uint)0x00010000)
 #define FEC_ENET_TS_TIMER       ((uint)0x00008000)
 
-#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII | FEC_ENET_TS_TIMER)
-#define FEC_NAPI_IMASK	(FEC_ENET_MII | FEC_ENET_TS_TIMER)
+#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII)
+#define FEC_NAPI_IMASK	FEC_ENET_MII
 #define FEC_RX_DISABLED_IMASK (FEC_DEFAULT_IMASK & (~FEC_ENET_RXF))
 
 /* ENET interrupt coalescing macro define */
-- 
2.5.0
