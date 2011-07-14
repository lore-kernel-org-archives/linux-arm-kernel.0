From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Jul 2011 01:52:04 +0200
Subject: [PATCH 6/7] at91rm9200/rtc: move register header to drivers
In-Reply-To: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1310687525-22486-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-at91rm9200.c                       |    2 +-
 .../at91_rtc.h => drivers/rtc/rtc-at91rm9200.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-at91/include/mach/at91_rtc.h => drivers/rtc/rtc-at91rm9200.h (98%)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index e39b77a..b916bd3 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -30,7 +30,7 @@
 
 #include <asm/uaccess.h>
 
-#include <mach/at91_rtc.h>
+#include "rtc-at91rm9200.h"
 
 
 #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
diff --git a/arch/arm/mach-at91/include/mach/at91_rtc.h b/drivers/rtc/rtc-at91rm9200.h
similarity index 98%
rename from arch/arm/mach-at91/include/mach/at91_rtc.h
rename to drivers/rtc/rtc-at91rm9200.h
index e56f470..cb2f7c6 100644
--- a/arch/arm/mach-at91/include/mach/at91_rtc.h
+++ b/drivers/rtc/rtc-at91rm9200.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/mach-at91/include/mach/at91_rtc.h
+ * drivers/rtc/rtc-at91rm9200.h
  *
  * Copyright (C) 2005 Ivan Kokshaysky
  * Copyright (C) SAN People
-- 
1.7.5.4
