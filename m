From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  9 Sep 2014 11:30:30 +0200
Subject: [PATCH v2 1/6] rtc: at91sam9: remove references to mach specific
 headers
In-Reply-To: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410255035-26775-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support multi platform kernel drivers should not include
machine specific headers.
Copy RTT macros in the driver code and remove any machine specific
headers.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 5963743..51f0038 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -22,10 +22,6 @@
 #include <linux/platform_data/atmel.h>
 #include <linux/io.h>
 
-#include <mach/at91_rtt.h>
-#include <mach/cpu.h>
-#include <mach/hardware.h>
-
 /*
  * This driver uses two configurable hardware resources that live in the
  * AT91SAM9 backup power domain (intended to be powered at all times)
@@ -47,6 +43,24 @@
  * registers available, likewise usable for more than "RTC" support.
  */
 
+#define AT91_RTT_MR		0x00			/* Real-time Mode Register */
+#define AT91_RTT_RTPRES		(0xffff << 0)		/* Real-time Timer Prescaler Value */
+#define AT91_RTT_ALMIEN		(1 << 16)		/* Alarm Interrupt Enable */
+#define AT91_RTT_RTTINCIEN	(1 << 17)		/* Real Time Timer Increment Interrupt Enable */
+#define AT91_RTT_RTTRST		(1 << 18)		/* Real Time Timer Restart */
+
+#define AT91_RTT_AR		0x04			/* Real-time Alarm Register */
+#define AT91_RTT_ALMV		(0xffffffff)		/* Alarm Value */
+
+#define AT91_RTT_VR		0x08			/* Real-time Value Register */
+#define AT91_RTT_CRTV		(0xffffffff)		/* Current Real-time Value */
+
+#define AT91_RTT_SR		0x0c			/* Real-time Status Register */
+#define AT91_RTT_ALMS		(1 << 0)		/* Real-time Alarm Status */
+#define AT91_RTT_RTTINC		(1 << 1)		/* Real-time Timer Increment */
+
+#define AT91_SLOW_CLOCK		32768
+
 /*
  * We store ALARM_DISABLED in ALMV to record that no alarm is set.
  * It's also the reset value for that field.
-- 
1.9.1
