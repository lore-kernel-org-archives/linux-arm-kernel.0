From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Jan 2014 11:07:18 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
Message-ID: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a firmware cannot be found for the SDMA engine then we can
continue with the inernal ROM firmware.

The meaning of this message is frequently asked for, so make clear
that the driver still works with the internal ROM firmware and reduce
the loglevel from err to info.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>
---

changes since v1:
- instead of removing the message make it more clear

 drivers/dma/imx-sdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c75679d..d79eaad 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1259,7 +1259,10 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	unsigned short *ram_code;
 
 	if (!fw) {
-		dev_err(sdma->dev, "firmware not found\n");
+		dev_info(sdma->dev, "external firmware not found, using ROM firmware\n");
+		/*
+		 * In this case we just use the ROM firmware.
+		 */
 		return;
 	}
 
-- 
1.8.5.2
