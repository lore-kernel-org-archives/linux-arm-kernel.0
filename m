From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 20 Jun 2013 11:17:39 +0200
Subject: [PATCH] dmaengine: ste_dma40: Declare memcpy config as static
Message-ID: <1371719859-4600-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sparse warnings:

drivers/dma/ste_dma40.c:81:26: warning: symbol 'dma40_memcpy_conf_phy' was not declared. Should it be static?
drivers/dma/ste_dma40.c:95:26: warning: symbol 'dma40_memcpy_conf_log' was not declared. Should it be static?

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---

Hi Linus,

just a quick sparse error fixup on the dma driver.

Thanks,
Fabio

 drivers/dma/ste_dma40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index fa4f9a3..8f72085 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -78,7 +78,7 @@ static int dma40_memcpy_channels[] = {
 };
 
 /* Default configuration for physcial memcpy */
-struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
+static struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
 	.mode = STEDMA40_MODE_PHYSICAL,
 	.dir = DMA_MEM_TO_MEM,
 
@@ -92,7 +92,7 @@ struct stedma40_chan_cfg dma40_memcpy_conf_phy = {
 };
 
 /* Default configuration for logical memcpy */
-struct stedma40_chan_cfg dma40_memcpy_conf_log = {
+static struct stedma40_chan_cfg dma40_memcpy_conf_log = {
 	.mode = STEDMA40_MODE_LOGICAL,
 	.dir = DMA_MEM_TO_MEM,
 
-- 
1.8.2
