From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Dec 2017 17:59:46 +0100
Subject: [PATCH net 2/3] net: mvneta: use proper rxq_number in loop on rx
 queues
In-Reply-To: <20171219165947.28516-1-gregory.clement@free-electrons.com>
References: <20171219165947.28516-1-gregory.clement@free-electrons.com>
Message-ID: <20171219165947.28516-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

When adding the RX queue association with each CPU, a typo was made in
the mvneta_cleanup_rxqs() function. This patch fixes it.

[gregory.clement at free-electrons.com: add commit log and fixes tag]
Cc: stable at vger.kernel.org
Fixes: 2dcf75e2793c ("net: mvneta: Associate RX queues with each CPU")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Tested-by: Dmitri Epshtein <dima@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 16b2bfb2cf51..1e0835655c93 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3015,7 +3015,7 @@ static void mvneta_cleanup_rxqs(struct mvneta_port *pp)
 {
 	int queue;
 
-	for (queue = 0; queue < txq_number; queue++)
+	for (queue = 0; queue < rxq_number; queue++)
 		mvneta_rxq_deinit(pp, &pp->rxqs[queue]);
 }
 
-- 
2.15.1
