From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 10:03:12 +0200
Subject: [PATCH 2/3] net: lpc_eth: Increase number of TX descriptors
In-Reply-To: <1339401793-12258-1-git-send-email-stigge@antcom.de>
References: <1339401793-12258-1-git-send-email-stigge@antcom.de>
Message-ID: <1339401793-12258-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have enough SRAM, we can increase the number of TX descriptors, so the
"BUSY" warning about occupied TX descriptors doesn't need to show up as often.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 drivers/net/ethernet/nxp/lpc_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/drivers/net/ethernet/nxp/lpc_eth.c
+++ linux-2.6/drivers/net/ethernet/nxp/lpc_eth.c
@@ -56,7 +56,7 @@
 
 #define ENET_MAXF_SIZE 1536
 #define ENET_RX_DESC 48
-#define ENET_TX_DESC 16
+#define ENET_TX_DESC 32
 
 #define NAPI_WEIGHT 16
 
