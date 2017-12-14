From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:32 +0100
Subject: [RFC PATCH 1/7] gpio: of: use the BIT macro for of_gpio_flags
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-2-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the BIT macro for the of_gpio_flags enumeration.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 include/linux/of_gpio.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 18a7f03e1182..f928c2df2bcd 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -14,6 +14,7 @@
 #ifndef __LINUX_OF_GPIO_H
 #define __LINUX_OF_GPIO_H
 
+#include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -28,10 +29,10 @@ struct device_node;
  * Linux-specific in their .xlate callback. Though, 1:1 mapping is recommended.
  */
 enum of_gpio_flags {
-	OF_GPIO_ACTIVE_LOW = 0x1,
-	OF_GPIO_SINGLE_ENDED = 0x2,
-	OF_GPIO_OPEN_DRAIN = 0x4,
-	OF_GPIO_TRANSITORY = 0x8,
+	OF_GPIO_ACTIVE_LOW	= BIT(0),
+	OF_GPIO_SINGLE_ENDED	= BIT(1),
+	OF_GPIO_OPEN_DRAIN	= BIT(2),
+	OF_GPIO_TRANSITORY	= BIT(3),
 };
 
 #ifdef CONFIG_OF_GPIO
-- 
2.12.2
