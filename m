From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Jan 2016 17:26:04 +0100
Subject: [PATCH net 3/6] net: mvneta: Remove unused code
In-Reply-To: <1454084767-24715-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454084767-24715-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1454084767-24715-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the commit 2dcf75e2793c ("net: mvneta: Associate RX queues with
each CPU") all the percpu irq are used and unmask at initialization, so
there is no point to unmask them first.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 3d6e3137f305..861b7e0d7d5f 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3009,14 +3009,6 @@ static int mvneta_open(struct net_device *dev)
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
