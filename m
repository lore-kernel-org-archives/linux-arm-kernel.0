From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:32 +0530
Subject: [PATCH 14/28] dmaengine: iop: use DMA_COMPLETE for dma completion
 status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-15-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/iop-adma.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index dd8b44a..408fe6b 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -864,7 +864,7 @@ static enum dma_status iop_adma_status(struct dma_chan *chan,
 	int ret;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_SUCCESS)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	iop_adma_slot_cleanup(iop_chan);
@@ -983,7 +983,7 @@ static int iop_adma_memcpy_self_test(struct iop_adma_device *device)
 	msleep(1);
 
 	if (iop_adma_status(dma_chan, cookie, NULL) !=
-			DMA_SUCCESS) {
+			DMA_COMPLETE) {
 		dev_err(dma_chan->device->dev,
 			"Self-test copy timed out, disabling\n");
 		err = -ENODEV;
@@ -1083,7 +1083,7 @@ iop_adma_xor_val_self_test(struct iop_adma_device *device)
 	msleep(8);
 
 	if (iop_adma_status(dma_chan, cookie, NULL) !=
-		DMA_SUCCESS) {
+		DMA_COMPLETE) {
 		dev_err(dma_chan->device->dev,
 			"Self-test xor timed out, disabling\n");
 		err = -ENODEV;
@@ -1129,7 +1129,7 @@ iop_adma_xor_val_self_test(struct iop_adma_device *device)
 	iop_adma_issue_pending(dma_chan);
 	msleep(8);
 
-	if (iop_adma_status(dma_chan, cookie, NULL) != DMA_SUCCESS) {
+	if (iop_adma_status(dma_chan, cookie, NULL) != DMA_COMPLETE) {
 		dev_err(dma_chan->device->dev,
 			"Self-test zero sum timed out, disabling\n");
 		err = -ENODEV;
@@ -1158,7 +1158,7 @@ iop_adma_xor_val_self_test(struct iop_adma_device *device)
 	iop_adma_issue_pending(dma_chan);
 	msleep(8);
 
-	if (iop_adma_status(dma_chan, cookie, NULL) != DMA_SUCCESS) {
+	if (iop_adma_status(dma_chan, cookie, NULL) != DMA_COMPLETE) {
 		dev_err(dma_chan->device->dev,
 			"Self-test non-zero sum timed out, disabling\n");
 		err = -ENODEV;
@@ -1254,7 +1254,7 @@ iop_adma_pq_zero_sum_self_test(struct iop_adma_device *device)
 	msleep(8);
 
 	if (iop_adma_status(dma_chan, cookie, NULL) !=
-		DMA_SUCCESS) {
+		DMA_COMPLETE) {
 		dev_err(dev, "Self-test pq timed out, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
@@ -1291,7 +1291,7 @@ iop_adma_pq_zero_sum_self_test(struct iop_adma_device *device)
 	msleep(8);
 
 	if (iop_adma_status(dma_chan, cookie, NULL) !=
-		DMA_SUCCESS) {
+		DMA_COMPLETE) {
 		dev_err(dev, "Self-test pq-zero-sum timed out, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
@@ -1323,7 +1323,7 @@ iop_adma_pq_zero_sum_self_test(struct iop_adma_device *device)
 	msleep(8);
 
 	if (iop_adma_status(dma_chan, cookie, NULL) !=
-		DMA_SUCCESS) {
+		DMA_COMPLETE) {
 		dev_err(dev, "Self-test !pq-zero-sum timed out, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
-- 
1.7.0.4
