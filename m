From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Jul 2011 01:52:00 +0200
Subject: [PATCH 2/7] at91/i2c: move register header to drivers
In-Reply-To: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1310687525-22486-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-i2c at vger.kernel.org
---
 drivers/i2c/busses/i2c-at91.c                      |    3 ++-
 .../at91_twi.h => drivers/i2c/busses/i2c-at91.h    |    7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/mach-at91/include/mach/at91_twi.h => drivers/i2c/busses/i2c-at91.h (97%)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 305c075..7402fed 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -25,10 +25,11 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/at91_twi.h>
 #include <mach/board.h>
 #include <mach/cpu.h>
 
+#include "i2c_at91.h"
+
 #define TWI_CLOCK		100000		/* Hz. max 400 Kbits/sec */
 
 
diff --git a/arch/arm/mach-at91/include/mach/at91_twi.h b/drivers/i2c/busses/i2c-at91.h
similarity index 97%
rename from arch/arm/mach-at91/include/mach/at91_twi.h
rename to drivers/i2c/busses/i2c-at91.h
index bb2880f..0f33ec7 100644
--- a/arch/arm/mach-at91/include/mach/at91_twi.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-at91/include/mach/at91_twi.h
+ * drivers/i2c/busses/i2c-at91.h
  *
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) SAN People
@@ -13,8 +13,8 @@
  * (at your option) any later version.
  */
 
-#ifndef AT91_TWI_H
-#define AT91_TWI_H
+#ifndef I2C_AT91_H
+#define I2C_AT91_H
 
 #define	AT91_TWI_CR		0x00		/* Control Register */
 #define		AT91_TWI_START		(1 <<  0)	/* Send a Start Condition */
@@ -65,4 +65,3 @@
 #define	AT91_TWI_THR		0x34		/* Transmit Holding Register */
 
 #endif
-
-- 
1.7.5.4
