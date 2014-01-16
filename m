From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 16:46:26 +0100
Subject: [PATCH] dma: imx-sdma: remove firmare not found warning
Message-ID: <1389887186-6146-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a firmware cannot be found for the SDMA engine then we can
continue with the inernal ROM firmware.

The meaning of this message is frequently asked for and the usual
answer is that this message is of no relevance, so just make it
dev_dbg() and do not alienate the users anymore.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/imx-sdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c75679d..fe57a42 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1259,7 +1259,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	unsigned short *ram_code;
 
 	if (!fw) {
-		dev_err(sdma->dev, "firmware not found\n");
+		dev_dbg(sdma->dev, "firmware not found\n");
+		/*
+		 * In this case we just use the ROM firmware.
+		 */
 		return;
 	}
 
-- 
1.8.5.2
