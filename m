From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:22:17 +0200
Subject: [PATCH 13/24] ste_dma40: Rename a jump label in
 d40_alloc_chan_resources()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <76bb4f48-c690-ccbb-91aa-ee57a769799a@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 15:15:15 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c7b73f1..0788add 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2424,7 +2424,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 		err = d40_config_memcpy(d40c);
 		if (err) {
 			chan_err(d40c, "Failed to configure memcpy channel\n");
-			goto fail;
+			goto mark_last_busy;
 		}
 	}
 
@@ -2432,7 +2432,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	if (err) {
 		chan_err(d40c, "Failed to allocate channel\n");
 		d40c->configured = false;
-		goto fail;
+		goto mark_last_busy;
 	}
 
 	pm_runtime_get_sync(d40c->base->dev);
@@ -2466,7 +2466,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	 */
 	if (is_free_phy)
 		d40_config_write(d40c);
-fail:
+ mark_last_busy:
 	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
-- 
2.10.0
