From: subashrp@gmail.com (Subash Patel)
Date: Mon, 10 Dec 2012 17:39:29 +0530
Subject: [PATCH] OF: update coherent_dma_mask
Message-ID: <1355141369-30030-1-git-send-email-subash.rp@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is tested in ARM:exynos5250 with LPAE enabled. The coherent_dma_mask
needs to be defined to DMA_BIT_MASK(64) as dma-mapping API's check it against
64-bit mask.

Signed-off-by: Subash Patel <subash.rp@samsung.com>
---
 drivers/of/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9bdeaf30..3c5417b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -214,7 +214,7 @@ struct platform_device *of_platform_device_create_pdata(
 #if defined(CONFIG_MICROBLAZE)
 	dev->archdata.dma_mask = 0xffffffffUL;
 #endif
-	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 
-- 
1.7.5.4
