From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 14:33:02 -0600
Subject: [PATCH v2 04/13] ARM: mc146818rtc: remove unnecessary include of
 mach/irqs.h
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
Message-ID: <1327091591-27125-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The include of mach/irqs.h isn't needed, so remove it. Compiled CMOS rtc
driver. Add a check to make sure nothing depends on RTC_IRQ.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/mc146818rtc.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/mc146818rtc.h b/arch/arm/include/asm/mc146818rtc.h
index 6b884d2..e8567bb 100644
--- a/arch/arm/include/asm/mc146818rtc.h
+++ b/arch/arm/include/asm/mc146818rtc.h
@@ -5,7 +5,9 @@
 #define _ASM_MC146818RTC_H
 
 #include <linux/io.h>
-#include <mach/irqs.h>
+#include <linux/kernel.h>
+
+#define RTC_IRQ BUILD_BUG_ON(1)
 
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
-- 
1.7.5.4
