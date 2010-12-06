From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  6 Dec 2010 11:09:57 +0100
Subject: [PATCH 1/2] dmaengine i.MX SDMA: initialize on module_init
In-Reply-To: <1291630198-9690-1-git-send-email-s.hauer@pengutronix.de>
References: <1291630198-9690-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1291630198-9690-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The firmware framework gets initialized during fs_initcall time, so
we are not allowed to call request_firmware earlier.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0834323..01c4a5f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1385,7 +1385,7 @@ static int __init sdma_module_init(void)
 {
 	return platform_driver_probe(&sdma_driver, sdma_probe);
 }
-subsys_initcall(sdma_module_init);
+module_init(sdma_module_init);
 
 MODULE_AUTHOR("Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("i.MX SDMA driver");
-- 
1.7.2.3
