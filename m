From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:07 +0000
Subject: [PATCH 08/13] rtc: at91rm9200: make IO endian agnostic
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-9-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the __raw IO calls to readl/write_relaxed which makes the driver
endian agnostic to run properly on big endian systems.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: rtc-linux at googlegroups.com
CC: linux-arm-kernel at lists.infradead.org
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/rtc/rtc-at91rm9200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index b4f7744..4106abc 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -37,9 +37,9 @@
 #include "rtc-at91rm9200.h"
 
 #define at91_rtc_read(field) \
-	__raw_readl(at91_rtc_regs + field)
+	readl_relaxed(at91_rtc_regs + field)
 #define at91_rtc_write(field, val) \
-	__raw_writel((val), at91_rtc_regs + field)
+	writel_relaxed((val), at91_rtc_regs + field)
 
 #define AT91_RTC_EPOCH		1900UL	/* just like arch/arm/common/rtctime.c */
 
-- 
2.1.4
