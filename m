From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  5 Sep 2017 11:16:32 -0700
Subject: [PATCH 3/3] drivers: net: xgene: Remove return statement from void
 function
In-Reply-To: <1504635392-19089-1-git-send-email-isubramanian@apm.com>
References: <1504635392-19089-1-git-send-email-isubramanian@apm.com>
Message-ID: <1504635392-19089-4-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 183db4 ("drivers: net: xgene: Correct probe sequence handling")
changed the return type of xgene_enet_check_phy_handle() to void.

This patch, removes the return statement from the last line.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 655c0fc..3b889ef 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1674,8 +1674,6 @@ static void xgene_enet_check_phy_handle(struct xgene_enet_pdata *pdata)
 	ret = xgene_enet_phy_connect(pdata->ndev);
 	if (!ret)
 		pdata->mdio_driver = true;
-
-	return;
 }
 
 static void xgene_enet_gpiod_get(struct xgene_enet_pdata *pdata)
-- 
2.7.4
