From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:53 +0100
Subject: [PATCH 15/30] dma: mv_xor: remove unused to_mv_xor_device() macro
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The to_mv_xor_device() macro is not being used by the driver, so we
can get rid of it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 3a54213..a999471 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -36,9 +36,6 @@ static void mv_xor_issue_pending(struct dma_chan *chan);
 #define to_mv_xor_chan(chan)		\
 	container_of(chan, struct mv_xor_chan, common)
 
-#define to_mv_xor_device(dev)		\
-	container_of(dev, struct mv_xor_device, common)
-
 #define to_mv_xor_slot(tx)		\
 	container_of(tx, struct mv_xor_desc_slot, async_tx)
 
-- 
1.7.9.5
