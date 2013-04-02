From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:19 +0900
Subject: [PATCH 23/30] ARM: shmobile: r8a7740: move global functions to
 r8a7740.h
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-24-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

There is no reason each CPU's own function has to exist in common.h.
r8a7740_xxx() go to r8a7740.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h  |    9 ---------
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 48eeca9..4d5410d 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -19,15 +19,6 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv, int index);
 extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
-extern void r8a7740_meram_workaround(void);
-extern void r8a7740_init_irq(void);
-extern void r8a7740_map_io(void);
-extern void r8a7740_add_early_devices(void);
-extern void r8a7740_add_standard_devices(void);
-extern void r8a7740_clock_init(u8 md_ck);
-extern void r8a7740_pinmux_init(void);
-extern void r8a7740_pm_init(void);
-
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq(void);
 extern void r8a7779_init_irq_extpin(int irlm);
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 59d252f..5a879bb 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -606,6 +606,15 @@ enum {
 	SHDMA_SLAVE_USBHS_RX,
 };
 
+extern void r8a7740_meram_workaround(void);
+extern void r8a7740_init_irq(void);
+extern void r8a7740_map_io(void);
+extern void r8a7740_add_early_devices(void);
+extern void r8a7740_add_standard_devices(void);
+extern void r8a7740_clock_init(u8 md_ck);
+extern void r8a7740_pinmux_init(void);
+extern void r8a7740_pm_init(void);
+
 #ifdef CONFIG_PM
 extern void __init r8a7740_init_pm_domains(void);
 #else
-- 
1.7.10.4
