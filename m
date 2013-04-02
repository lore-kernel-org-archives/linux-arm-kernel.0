From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:18 +0900
Subject: [PATCH 22/30] ARM: shmobile: sh73a0: move global functions to sh73a0.h
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-23-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

There is no reason each CPU's own function has to exist in common.h.
sh73a0_xxx() go to sh73a0.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h |   16 ----------------
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index d01a551..48eeca9 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,22 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void sh73a0_init_delay(void);
-extern void sh73a0_init_irq(void);
-extern void sh73a0_init_irq_dt(void);
-extern void sh73a0_map_io(void);
-extern void sh73a0_earlytimer_init(void);
-extern void sh73a0_add_early_devices(void);
-extern void sh73a0_add_standard_devices(void);
-extern void sh73a0_add_standard_devices_dt(void);
-extern void sh73a0_clock_init(void);
-extern void sh73a0_pinmux_init(void);
-extern void sh73a0_pm_init(void);
-extern struct clk sh73a0_extal1_clk;
-extern struct clk sh73a0_extal2_clk;
-extern struct clk sh73a0_extcki_clk;
-extern struct clk sh73a0_extalr_clk;
-
 extern void r8a7740_meram_workaround(void);
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 606d31d..936da1b 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -557,6 +557,21 @@ enum {
 #define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
 #define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
 
+extern void sh73a0_init_delay(void);
+extern void sh73a0_init_irq(void);
+extern void sh73a0_init_irq_dt(void);
+extern void sh73a0_map_io(void);
+extern void sh73a0_earlytimer_init(void);
+extern void sh73a0_add_early_devices(void);
+extern void sh73a0_add_standard_devices(void);
+extern void sh73a0_add_standard_devices_dt(void);
+extern void sh73a0_clock_init(void);
+extern void sh73a0_pinmux_init(void);
+extern void sh73a0_pm_init(void);
+extern struct clk sh73a0_extal1_clk;
+extern struct clk sh73a0_extal2_clk;
+extern struct clk sh73a0_extcki_clk;
+extern struct clk sh73a0_extalr_clk;
 extern struct smp_operations sh73a0_smp_ops;
 
 #endif /* __ASM_SH73A0_H__ */
-- 
1.7.10.4
