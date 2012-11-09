From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 9 Nov 2012 11:11:40 +0100
Subject: [PATCH] i2c: at91: fix compilation issue due to header move
Message-ID: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

arch/arm/mach-at91/include/mach/at_hdmac.h has been move to
include/linux/platform_data/dma-atmel.h, commit 7cdc39e.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

This is a fix for 3.7.

Regards

Ludovic

 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index a9fbad8..e2e9837 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -32,7 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <mach/at_hdmac.h>
+#include <linux/platform_data/dma-atmel.h>
 
 #define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
 #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
-- 
1.7.11.3
