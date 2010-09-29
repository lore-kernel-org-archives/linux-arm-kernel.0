From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 29 Sep 2010 18:02:14 +0800
Subject: [PATCH 1/2] rtc: avoid checking cpuid in pxa-rtc
Message-ID: <1285754535-30802-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa-rtc is widely used in pxa27x/pxa3xx/pxa93x/pxa95x. Checking cpuid in
pxa-rtc driver is unnecessary since we assign on-chip device in soc files.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>
---
 drivers/rtc/rtc-pxa.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 29e867a..4bcc520 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -477,10 +477,7 @@ static struct platform_driver pxa_rtc_driver = {
 
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
1.5.6.5
