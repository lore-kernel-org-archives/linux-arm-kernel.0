From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:51 -0700
Subject: [PATCH net-next 27/40] net: fec: enable interrupt on very last
 descriptor only
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-28-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cf53e21..7258051 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -689,7 +689,8 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 							bdp, index,
 							tso.data, size,
 							size == data_left,
-							total_len == 0);
+							(total_len == 0) &&
+							(size == data_left));
 			if (ret)
 				goto err_release;
 
-- 
2.5.0
