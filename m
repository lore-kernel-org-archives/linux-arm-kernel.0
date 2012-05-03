From: r.sricharan@ti.com (R Sricharan)
Date: Thu, 3 May 2012 12:56:13 +0530
Subject: [PATCH 04/13] ARM: OMAP5: timer: Add clocksource, clockevent support
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1336029982-31898-5-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the Initialisaton for clocksource and clockevent device
on OMAP5 Socs.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/common.h |    1 +
 arch/arm/mach-omap2/timer.c  |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 797dda7..88fb577 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -92,6 +92,7 @@ extern struct sys_timer omap2_timer;
 extern struct sys_timer omap3_timer;
 extern struct sys_timer omap3_secure_timer;
 extern struct sys_timer omap4_timer;
+extern struct sys_timer omap5_timer;
 
 void omap2420_init_early(void);
 void omap2430_init_early(void);
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c512bac..3262ad6 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -348,6 +348,11 @@ static void __init omap4_timer_init(void)
 OMAP_SYS_TIMER(4)
 #endif
 
+#ifdef CONFIG_ARCH_OMAP5
+OMAP_SYS_TIMER_INIT(5, 1, OMAP4_CLKEV_SOURCE, 2, OMAP4_MPU_SOURCE)
+OMAP_SYS_TIMER(5)
+#endif
+
 /**
  * omap2_dm_timer_set_src - change the timer input clock source
  * @pdev:	timer platform device pointer
-- 
1.7.1
