From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 01:45:20 +0100
Subject: [PATCH 6/7] ARM: SAMSUNG: use clk_prepare_enable in samsung-time
In-Reply-To: <201303120141.31262.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
Message-ID: <201303120145.21072.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clock framework expects clocks to be prepared
before they are enabled.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/samsung-time.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/samsung-time.c b/arch/arm/plat-samsung/samsung-time.c
index f899cbc..6ebb851 100644
--- a/arch/arm/plat-samsung/samsung-time.c
+++ b/arch/arm/plat-samsung/samsung-time.c
@@ -355,7 +355,7 @@ static void __init samsung_timer_resources(void)
 	if (IS_ERR(timerclk))
 		panic("failed to get timers clock for timer");
 
-	clk_enable(timerclk);
+	clk_prepare_enable(timerclk);
 
 	sprintf(devname, "s3c24xx-pwm.%lu", event_id);
 	s3c_device_timer[event_id].id = event_id;
@@ -369,7 +369,7 @@ static void __init samsung_timer_resources(void)
 	if (IS_ERR(tdiv_event))
 		panic("failed to get pwm-tdiv clock for event timer");
 
-	clk_enable(tin_event);
+	clk_prepare_enable(tin_event);
 
 	sprintf(devname, "s3c24xx-pwm.%lu", source_id);
 	s3c_device_timer[source_id].id = source_id;
@@ -383,7 +383,7 @@ static void __init samsung_timer_resources(void)
 	if (IS_ERR(tdiv_source))
 		panic("failed to get pwm-tdiv clock for source timer");
 
-	clk_enable(tin_source);
+	clk_prepare_enable(tin_source);
 }
 
 void __init samsung_timer_init(void)
-- 
1.7.2.3
