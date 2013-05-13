From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:31 +0400
Subject: [PATCH 09/15] ARM: clps711x: Replace "arch_initcall" in common code
 with ".init_early"
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-12-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c |  1 +
 arch/arm/mach-clps711x/board-cdb89712.c |  1 +
 arch/arm/mach-clps711x/board-clep7312.c |  1 +
 arch/arm/mach-clps711x/board-edb7211.c  |  1 +
 arch/arm/mach-clps711x/board-fortunet.c |  1 +
 arch/arm/mach-clps711x/board-p720t.c    |  1 +
 arch/arm/mach-clps711x/common.c         | 10 +++-------
 arch/arm/mach-clps711x/common.h         |  1 +
 8 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index cd50314..5867aeb 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -271,6 +271,7 @@ MACHINE_START(AUTCPU12, "autronix autcpu12")
 	.atag_offset	= 0x20000,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
+	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= autcpu12_init,
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index a80ae57..a9e38c6 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -141,6 +141,7 @@ MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	.atag_offset	= 0x100,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
+	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= cdb89712_init,
diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index 014aa3c..b476424 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -39,6 +39,7 @@ MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
+	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.handle_irq	= clps711x_handle_irq,
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 3ba4b9e..db804b4 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -182,6 +182,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
 	.map_io		= edb7211_map_io,
+	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
diff --git a/arch/arm/mach-clps711x/board-fortunet.c b/arch/arm/mach-clps711x/board-fortunet.c
index c5675ef..b1561e3 100644
--- a/arch/arm/mach-clps711x/board-fortunet.c
+++ b/arch/arm/mach-clps711x/board-fortunet.c
@@ -77,6 +77,7 @@ MACHINE_START(FORTUNET, "ARM-FortuNet")
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fortunet_fixup,
 	.map_io		= clps711x_map_io,
+	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.handle_irq	= clps711x_handle_irq,
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 601ef38..dd81b06 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -366,6 +366,7 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_p720t,
 	.map_io		= clps711x_map_io,
+	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= p720t_init,
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index f42302e..768d41c6 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -354,15 +354,11 @@ void clps711x_restart(char mode, const char *cmd)
 static void clps711x_idle(void)
 {
 	clps_writel(1, HALT);
-	__asm__ __volatile__(
-	"mov    r0, r0\n\
-	mov     r0, r0");
+	asm("mov r0, r0");
+	asm("mov r0, r0");
 }
 
-static int __init clps711x_idle_init(void)
+void __init clps711x_init_early(void)
 {
 	arm_pm_idle = clps711x_idle;
-	return 0;
 }
-
-arch_initcall(clps711x_idle_init);
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index f84a729..2a22f4c 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -13,3 +13,4 @@ extern void clps711x_init_irq(void);
 extern void clps711x_timer_init(void);
 extern void clps711x_handle_irq(struct pt_regs *regs);
 extern void clps711x_restart(char mode, const char *cmd);
+extern void clps711x_init_early(void);
-- 
1.8.1.5
