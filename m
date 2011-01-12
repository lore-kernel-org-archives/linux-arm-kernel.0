From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Jan 2011 15:39:08 +0100
Subject: [PATCH 4/6] dmaengine: at_hdmac: use subsys_initcall instead of
	module_init
In-Reply-To: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292435416-16927-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1294843150-6962-3-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Xu <hong.xu@atmel.com>

Use subsys_initcall instead of module_init in order to keep DMA engine rolling
before other peripheral drivers.

Signed-off-by: Eric Xu <hong.xu@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 4f83431..a1a0fc6 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1209,7 +1209,7 @@ static int __init at_dma_init(void)
 {
 	return platform_driver_probe(&at_dma_driver, at_dma_probe);
 }
-module_init(at_dma_init);
+subsys_initcall(at_dma_init);
 
 static void __exit at_dma_exit(void)
 {
-- 
1.7.3
