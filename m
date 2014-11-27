From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 27 Nov 2014 12:41:29 +0200
Subject: [PATCH 1/3] ASoC: davinci-evm: Do not include edma headers
In-Reply-To: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1417084891-17990-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine driver has no business with the underlying dma.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-evm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 158cb3d1db70..d1a8b6e3ac3b 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -14,7 +14,6 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/edma.h>
 #include <linux/i2c.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
@@ -25,8 +24,6 @@
 #include <asm/dma.h>
 #include <asm/mach-types.h>
 
-#include <linux/edma.h>
-
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 
-- 
2.1.3
