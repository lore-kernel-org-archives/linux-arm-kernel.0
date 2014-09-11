From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 10:56:01 +0200
Subject: [PATCH v3 2/8] rtc: at91sam9: use standard readl/writel functions
 instead of raw versions
In-Reply-To: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410425767-17874-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 51f0038..74a9ca0 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -77,14 +77,14 @@ struct sam9_rtc {
 };
 
 #define rtt_readl(rtc, field) \
-	__raw_readl((rtc)->rtt + AT91_RTT_ ## field)
+	readl((rtc)->rtt + AT91_RTT_ ## field)
 #define rtt_writel(rtc, field, val) \
-	__raw_writel((val), (rtc)->rtt + AT91_RTT_ ## field)
+	writel((val), (rtc)->rtt + AT91_RTT_ ## field)
 
 #define gpbr_readl(rtc) \
-	__raw_readl((rtc)->gpbr)
+	readl((rtc)->gpbr)
 #define gpbr_writel(rtc, val) \
-	__raw_writel((val), (rtc)->gpbr)
+	writel((val), (rtc)->gpbr)
 
 /*
  * Read current time and date in RTC
-- 
1.9.1
