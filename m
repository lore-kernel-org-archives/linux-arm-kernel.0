From: shijie8@gmail.com (Huang Shijie)
Date: Wed,  6 Jun 2012 21:22:59 -0400
Subject: [PATCH v2 3/3] dma: enable mxs-dma for imx6q
In-Reply-To: <1339032179-2732-1-git-send-email-shijie8@gmail.com>
References: <1339032179-2732-1-git-send-email-shijie8@gmail.com>
Message-ID: <1339032179-2732-3-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the mxs-dma for imx6q.
Also remove the unused header file.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/dma/Kconfig   |    2 +-
 drivers/dma/mxs-dma.c |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index aadeb5b..c8416d5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -237,7 +237,7 @@ config IMX_DMA
 
 config MXS_DMA
 	bool "MXS DMA support"
-	depends on SOC_IMX23 || SOC_IMX28
+	depends on SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q
 	select STMP_DEVICE
 	select DMA_ENGINE
 	help
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c96ab15..90b980d 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -29,7 +29,6 @@
 #include <linux/of_device.h>
 
 #include <asm/irq.h>
-#include <mach/mxs.h>
 
 #include "dmaengine.h"
 
-- 
1.7.4.4
