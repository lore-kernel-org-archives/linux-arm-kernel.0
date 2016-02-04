From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  4 Feb 2016 22:09:26 +0100
Subject: [PATCH v3 net 4/7] net: mvneta: Remove unused code
In-Reply-To: <1454620169-8156-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454620169-8156-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1454620169-8156-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the commit 2dcf75e2793c ("net: mvneta: Associate RX queues with
each CPU") all the percpu irq are used and disabled at initialization, so
there is no point to disable them first.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f496f9716569..74f8158df2b0 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3014,14 +3014,6 @@ static int mvneta_open(struct net_device *dev)
 		goto err_cleanup_txqs;
 	}
 
-	/* Even though the documentation says that request_percpu_irq
-	 * doesn't enable the interrupts automatically, it actually
-	 * does so on the local CPU.
-	 *
-	 * Make sure it's disabled.
-	 */
-	mvneta_percpu_disable(pp);
-
 	/* Enable per-CPU interrupt on all the CPU to handle our RX
 	 * queue interrupts
 	 */
-- 
2.5.0
