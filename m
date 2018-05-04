From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri,  4 May 2018 12:34:46 +0200
Subject: [PATCH REPOST] mfd: syscon: atmel-smc: include string.h
Message-ID: <20180504103446.20104-1-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The string.h header file is needed for the memset() definition. The RT
build fails because it is not pulled in via other header files.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/atmel-smc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/mfd/syscon/atmel-smc.h>
+#include <linux/string.h>
 
 /**
  * atmel_smc_cs_conf_init - initialize a SMC CS conf
