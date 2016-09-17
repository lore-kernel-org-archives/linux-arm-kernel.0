From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:34:26 +0200
Subject: [PATCH 22/24] ste_dma40: Rename a jump label in dma_tasklet()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <85371665-dd15-287b-d459-1f54fcfd525b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:23:43 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 4a2f39b..0082ae0 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1606,7 +1606,7 @@ static void dma_tasklet(unsigned long data)
 		/* Check if we have reached here for cyclic job */
 		d40d = d40_first_active_get(d40c);
 		if (d40d == NULL || !d40d->cyclic)
-			goto err;
+			goto check_pending_tx;
 	}
 
 	if (!d40d->cyclic)
@@ -1648,8 +1648,7 @@ static void dma_tasklet(unsigned long data)
 		dmaengine_desc_callback_invoke(&cb, NULL);
 
 	return;
-
-err:
+ check_pending_tx:
 	/* Rescue manouver if receiving double interrupts */
 	if (d40c->pending_tx > 0)
 		d40c->pending_tx--;
-- 
2.10.0
