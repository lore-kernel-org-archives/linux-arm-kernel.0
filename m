From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 10 Apr 2016 21:29:58 +0200
Subject: [PATCH 1/3] ARM: pxa: prepare pxa25x interrupts for device-tree
 platforms
Message-ID: <1460316600-15978-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device-tree interrupts initialization function required to have
a generic pxa25x device-tree machine.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/generic.h | 1 +
 arch/arm/mach-pxa/pxa25x.c  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 0b1dbb54871a..3f914d97cac2 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -27,6 +27,7 @@ extern void pxa_timer_init(void);
 
 #define pxa25x_handle_irq icip_handle_irq
 extern int __init pxa25x_clocks_init(void);
+extern void __init pxa25x_dt_init_irq(void);
 extern void __init pxa25x_init_irq(void);
 extern void __init pxa25x_map_io(void);
 extern void __init pxa26x_init_irq(void);
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 823504f48f80..a0de9a9ae64e 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -151,6 +151,12 @@ void __init pxa26x_init_irq(void)
 }
 #endif
 
+void __init pxa25x_dt_init_irq(void)
+{
+	if (IS_ENABLED(CONFIG_OF))
+		pxa_dt_irq_init(pxa25x_set_wake);
+}
+
 static struct map_desc pxa25x_io_desc[] __initdata = {
 	{	/* Mem Ctl */
 		.virtual	= (unsigned long)SMEMC_VIRT,
-- 
2.1.4
