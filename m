From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:20 +0900
Subject: [PATCH 24/30] ARM: shmobile: r8a7779: move global functions to
 r8a7779.h
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-25-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

There is no reason each CPU's own function has to exist in common.h.
r8a7779_xxx() go to r8a7779.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h  |   14 --------------
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   13 +++++++++++++
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 4d5410d..e002cfd 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,20 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void r8a7779_init_delay(void);
-extern void r8a7779_init_irq(void);
-extern void r8a7779_init_irq_extpin(int irlm);
-extern void r8a7779_init_irq_dt(void);
-extern void r8a7779_map_io(void);
-extern void r8a7779_earlytimer_init(void);
-extern void r8a7779_add_early_devices(void);
-extern void r8a7779_add_standard_devices(void);
-extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_clock_init(void);
-extern void r8a7779_pinmux_init(void);
-extern void r8a7779_pm_init(void);
-extern void r8a7779_register_twd(void);
-
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
 #else
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 8ab0cd6..af38750 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -343,6 +343,19 @@ static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
 
+extern void r8a7779_init_delay(void);
+extern void r8a7779_init_irq(void);
+extern void r8a7779_init_irq_extpin(int irlm);
+extern void r8a7779_init_irq_dt(void);
+extern void r8a7779_map_io(void);
+extern void r8a7779_earlytimer_init(void);
+extern void r8a7779_add_early_devices(void);
+extern void r8a7779_add_standard_devices(void);
+extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_clock_init(void);
+extern void r8a7779_pinmux_init(void);
+extern void r8a7779_pm_init(void);
+extern void r8a7779_register_twd(void);
 extern int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch);
 extern int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch);
 
-- 
1.7.10.4
