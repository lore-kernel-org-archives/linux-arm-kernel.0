From: avinashphilipk@gmail.com (Philip Avinash)
Date: Fri, 14 Jun 2013 15:27:49 +0530
Subject: [PATCH 2/2] gpio: gpio-tnetv107x: Fix bulid breakge
In-Reply-To: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
References: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
Message-ID: <1371203869-16308-3-git-send-email-avinashphilipk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

includes linux/io.h for fixing following build error. This build error
comes only after removing select option of NEED_MACH_GPIO_H for
ARCH_DAVINCI. linux/io.h is got included from mach/gpio-davinci.h on
selection of NEED_MACH_GPIO_H.

drivers/gpio/gpio-tnetv107x.c: In function 'tnetv107x_gpio_request':
drivers/gpio/gpio-tnetv107x.c:63:2: error: implicit declaration of
function '__raw_writel'
drivers/gpio/gpio-tnetv107x.c:63:2: error: implicit declaration of
function '__raw_readl'
drivers/gpio/gpio-tnetv107x.c: In function 'tnetv107x_gpio_setup':
drivers/gpio/gpio-tnetv107x.c:172:2: error: implicit declaration of
function 'ioremap'
drivers/gpio/gpio-tnetv107x.c:172:7: warning: assignment makes pointer
from integer without a cast

Signed-off-by: Philip Avinash <avinashphilipk@gmail.com>
---
 drivers/gpio/gpio-tnetv107x.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tnetv107x.c b/drivers/gpio/gpio-tnetv107x.c
index 3fa3e28..c7ed335 100644
--- a/drivers/gpio/gpio-tnetv107x.c
+++ b/drivers/gpio/gpio-tnetv107x.c
@@ -14,6 +14,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/gpio.h>
 
 #include <mach/common.h>
-- 
1.7.9.5
