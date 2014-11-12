From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Nov 2014 20:04:29 -0200
Subject: [PATCH] dma: imx-sdma: clarify about firmware not found error
Message-ID: <1415829869-6661-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

When a firmware cannot be found for the SDMA engine then we can
continue with the internal ROM firmware.

The meaning of this message is frequently asked for, so make clear
that the driver still works with the internal ROM firmware and reduce
the loglevel from err to info.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/dma/imx-sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 99d8833..2c67da5 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1287,7 +1287,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	unsigned short *ram_code;
 
 	if (!fw) {
-		dev_err(sdma->dev, "firmware not found\n");
+		dev_info(sdma->dev, "external firmware not found, using ROM firmware\n");
+		/* In this case we just use the ROM firmware. */
 		return;
 	}
 
-- 
1.9.1
