From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:33 -0700
Subject: [PATCH net-next 09/40] net: fec: only check queue 0 if RXF_0/TXF_0
 interrupt is set
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-10-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 15a93f90..3ed79fd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1523,14 +1523,14 @@ fec_enet_collect_events(struct fec_enet_private *fep, uint int_events)
 	if (int_events == 0)
 		return false;
 
-	if (int_events & FEC_ENET_RXF)
+	if (int_events & FEC_ENET_RXF_0)
 		fep->work_rx |= (1 << 2);
 	if (int_events & FEC_ENET_RXF_1)
 		fep->work_rx |= (1 << 0);
 	if (int_events & FEC_ENET_RXF_2)
 		fep->work_rx |= (1 << 1);
 
-	if (int_events & FEC_ENET_TXF)
+	if (int_events & FEC_ENET_TXF_0)
 		fep->work_tx |= (1 << 2);
 	if (int_events & FEC_ENET_TXF_1)
 		fep->work_tx |= (1 << 0);
-- 
2.5.0
