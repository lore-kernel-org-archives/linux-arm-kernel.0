From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 16 Aug 2012 19:59:08 +0800
Subject: [PATCH 1/3] rtc: avoid cpuid checking in pxa-rtc
Message-ID: <1345118348-10255-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@marvell.com>

pxa-rtc is widely used in pxa27x/pxa3xx/pxa93x/pxa95x. Checking cpuid in
pxa-rtc driver is unnecessary since we assign on-chip device in soc files.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-pxa.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 0075c8f..a2c3534 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -433,10 +433,7 @@ static struct platform_driver pxa_rtc_driver = {
 
 static int __init pxa_rtc_init(void)
 {
-	if (cpu_is_pxa27x() || cpu_is_pxa3xx())
-		return platform_driver_probe(&pxa_rtc_driver, pxa_rtc_probe);
-
-	return -ENODEV;
+	return platform_driver_probe(&pxa_rtc_driver, pxa_rtc_probe);
 }
 
 static void __exit pxa_rtc_exit(void)
-- 
1.7.0.4
