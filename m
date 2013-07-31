From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:03:00 +0900
Subject: [PATCH 12/13] ARM: shmobile: Use clocksource_of_init() on r8a7790
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190300.31796.23926.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the call to shmobile_timer_init() with
clocksource_of_init(). This will allow us to
get rid of shmobile_timer_init().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-08-01 03:17:48.000000000 +0900
@@ -263,7 +263,7 @@ void __init r8a7790_timer_init(void)
 	iounmap(base);
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
-	shmobile_timer_init();
+	clocksource_of_init();
 }
 
 void __init r8a7790_init_delay(void)
