From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:17 +0900
Subject: [PATCH 21/30] ARM: shmobile: sh7372: move global functions to sh7372.h
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-22-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

There is no reason each CPU's own function has to exist in common.h.
sh7372_xxx() go to sh7372.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |   15 ---------------
 arch/arm/mach-shmobile/include/mach/sh7372.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 03f73de..d01a551 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,21 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void sh7372_init_irq(void);
-extern void sh7372_map_io(void);
-extern void sh7372_earlytimer_init(void);
-extern void sh7372_add_early_devices(void);
-extern void sh7372_add_standard_devices(void);
-extern void sh7372_add_early_devices_dt(void);
-extern void sh7372_add_standard_devices_dt(void);
-extern void sh7372_clock_init(void);
-extern void sh7372_pinmux_init(void);
-extern void sh7372_pm_init(void);
-extern void sh7372_resume_core_standby_sysc(void);
-extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
-extern struct clk sh7372_extal1_clk;
-extern struct clk sh7372_extal2_clk;
-
 extern void sh73a0_init_delay(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index b582fac..f0ea60d 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -478,6 +478,18 @@ extern struct clk sh7372_dv_clki_clk;
 extern struct clk sh7372_dv_clki_div2_clk;
 extern struct clk sh7372_pllc2_clk;
 
+extern void sh7372_init_irq(void);
+extern void sh7372_map_io(void);
+extern void sh7372_earlytimer_init(void);
+extern void sh7372_add_early_devices(void);
+extern void sh7372_add_standard_devices(void);
+extern void sh7372_add_early_devices_dt(void);
+extern void sh7372_add_standard_devices_dt(void);
+extern void sh7372_clock_init(void);
+extern void sh7372_pinmux_init(void);
+extern void sh7372_pm_init(void);
+extern void sh7372_resume_core_standby_sysc(void);
+extern int  sh7372_do_idle_sysc(unsigned long sleep_mode);
 extern void sh7372_intcs_suspend(void);
 extern void sh7372_intcs_resume(void);
 extern void sh7372_intca_suspend(void);
-- 
1.7.10.4
