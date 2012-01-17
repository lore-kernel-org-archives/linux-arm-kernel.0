From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jan 2012 20:40:12 -0600
Subject: [PATCH 2/2] ARM: highbank: enable sp804 based sched_clock
In-Reply-To: <1326768012-2719-1-git-send-email-robherring2@gmail.com>
References: <1326768012-2719-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326768012-2719-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Initialize sched_clock to use the sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 804c4a5..564a0c3 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -111,7 +111,7 @@ static void __init highbank_timer_init(void)
 
 	highbank_clocks_init();
 
-	sp804_clocksource_init(timer_base + 0x20, "timer1");
+	sp804_clocksource_and_sched_clock_init(timer_base + 0x20, "timer1");
 	sp804_clockevents_init(timer_base, irq, "timer0");
 }
 
-- 
1.7.5.4
