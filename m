From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:20:29 +0200
Subject: [PATCH 12/24] ste_dma40: Rename jump labels in d40_dmaengine_init()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <50af4724-d6a8-7e19-d5b1-c23c088b844b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 15:10:15 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index ed96039..c7b73f1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2889,7 +2889,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 
 	if (err) {
 		d40_err(base->dev, "Failed to register slave channels\n");
-		goto failure1;
+		goto exit;
 	}
 
 	d40_chan_init(base, &base->dma_memcpy, base->log_chans,
@@ -2906,7 +2906,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	if (err) {
 		d40_err(base->dev,
 			"Failed to register memcpy only channels\n");
-		goto failure2;
+		goto unregister_slave;
 	}
 
 	d40_chan_init(base, &base->dma_both, base->phy_chans,
@@ -2924,14 +2924,14 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	if (err) {
 		d40_err(base->dev,
 			"Failed to register logical and physical capable channels\n");
-		goto failure3;
+		goto unregister_memcpy;
 	}
 	return 0;
-failure3:
+ unregister_memcpy:
 	dma_async_device_unregister(&base->dma_memcpy);
-failure2:
+ unregister_slave:
 	dma_async_device_unregister(&base->dma_slave);
-failure1:
+ exit:
 	return err;
 }
 
-- 
2.10.0
