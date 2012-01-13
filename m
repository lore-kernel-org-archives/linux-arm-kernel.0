From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:02 -0600
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Since asm/irq.h may not include mach/irqs.h, include mach/irqs.h directly.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/rtc/rtc-sa1100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 4595d3e..144fa06 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -33,7 +33,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/irq.h>
+#include <mach/irqs.h>
 
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
-- 
1.7.5.4
