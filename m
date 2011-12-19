From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:32 -0500
Subject: [PATCH 03/20] ARM: mach-s5pc100: use standard arch_idle()
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is equivalent and more similar to existing architectures.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-s5pc100/cpu.c                 |   12 ------------
 arch/arm/mach-s5pc100/include/mach/system.h |    2 +-
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index fd2708e7d8..82da5d706a 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -92,14 +92,6 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 	}
 };
 
-static void s5pc100_idle(void)
-{
-	if (!need_resched())
-		cpu_do_idle();
-
-	local_irq_enable();
-}
-
 /* s5pc100_map_io
  *
  * register the standard cpu IO areas
@@ -161,9 +153,5 @@ core_initcall(s5pc100_core_init);
 int __init s5pc100_init(void)
 {
 	printk(KERN_INFO "S5PC100: Initializing architecture\n");
-
-	/* set idle function */
-	pm_idle = s5pc100_idle;
-
 	return sysdev_register(&s5pc100_sysdev);
 }
diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-s5pc100/include/mach/system.h
index a9ea57c066..ebfeb943f5 100644
--- a/arch/arm/mach-s5pc100/include/mach/system.h
+++ b/arch/arm/mach-s5pc100/include/mach/system.h
@@ -15,7 +15,7 @@
 
 static void arch_idle(void)
 {
-	/* nothing here yet */
+	cpu_do_idle();
 }
 
 #endif /* __ASM_ARCH_IRQ_H */
-- 
1.7.7.1.431.g10b2a
