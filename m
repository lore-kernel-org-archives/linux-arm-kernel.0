From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:31:23 +0200
Subject: [PATCH 19/24] ste_dma40: Rename a jump label in d40_free_dma()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <7fb277bb-0967-792d-1d56-4375976afbf5@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 16:04:46 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index d99241c..917b24a 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2045,7 +2045,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 	res = d40_channel_execute_command(d40c, D40_DMA_STOP);
 	if (res) {
 		chan_err(d40c, "stop failed\n");
-		goto out;
+		goto mark_last_busy;
 	}
 
 	d40_alloc_mask_free(phy, is_src, chan_is_logical(d40c) ? event : 0);
@@ -2063,8 +2063,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 	d40c->busy = false;
 	d40c->phy_chan = NULL;
 	d40c->configured = false;
-out:
-
+ mark_last_busy:
 	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	return res;
-- 
2.10.0
