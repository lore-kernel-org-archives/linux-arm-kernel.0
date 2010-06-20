From: eric.miao@canonical.com (Eric Miao)
Date: Sun, 20 Jun 2010 22:00:50 +0800
Subject: [PATCH 2/2] [ARM] pxa: make use of 'struct machine_class'
In-Reply-To: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
References: <1277042450-30382-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1277042450-30382-2-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.y.miao@gmail.com>

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/mach-pxa/ezx.c      |   60 ++++-------------------------------------
 arch/arm/mach-pxa/generic.h  |   15 ++++++++++
 arch/arm/mach-pxa/hx4700.c   |   10 +------
 arch/arm/mach-pxa/magician.c |    9 +-----
 arch/arm/mach-pxa/pxa25x.c   |   11 +++++++
 arch/arm/mach-pxa/pxa27x.c   |   11 +++++++
 6 files changed, 46 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 626c82b..2f4c8f1 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -795,15 +795,7 @@ static void __init a780_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(a780_devices));
 }
 
-MACHINE_START(EZX_A780, "Motorola EZX A780")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = a780_init,
-MACHINE_END
+PXA27X_MACHINE(EZX_A780, a780_init, "Motorola EZX A780");
 #endif
 
 #ifdef CONFIG_MACH_EZX_E680
@@ -861,15 +853,7 @@ static void __init e680_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(e680_devices));
 }
 
-MACHINE_START(EZX_E680, "Motorola EZX E680")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = e680_init,
-MACHINE_END
+PXA27X_MACHINE(EZX_E680, e680_init, "Motorola EZX E680");
 #endif
 
 #ifdef CONFIG_MACH_EZX_A1200
@@ -927,15 +911,7 @@ static void __init a1200_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(a1200_devices));
 }
 
-MACHINE_START(EZX_A1200, "Motorola EZX A1200")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = a1200_init,
-MACHINE_END
+PXA27X_MACHINE(EZX_A1200, a1200_init, "Motorola EZX A1200");
 #endif
 
 #ifdef CONFIG_MACH_EZX_A910
@@ -1119,15 +1095,7 @@ static void __init a910_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(a910_devices));
 }
 
-MACHINE_START(EZX_A910, "Motorola EZX A910")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = a910_init,
-MACHINE_END
+PXA27X_MACHINE(EZX_A910, a910_init, "Motorola EZX A910");
 #endif
 
 #ifdef CONFIG_MACH_EZX_E6
@@ -1185,15 +1153,7 @@ static void __init e6_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(e6_devices));
 }
 
-MACHINE_START(EZX_E6, "Motorola EZX E6")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = e6_init,
-MACHINE_END
+PXA27X_MACHINE(EZX_E6, e6_init, "Motorola EZX E6");
 #endif
 
 #ifdef CONFIG_MACH_EZX_E2
@@ -1225,13 +1185,5 @@ static void __init e2_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(e2_devices));
 }
 
-MACHINE_START(EZX_E2, "Motorola EZX E2")
-	.phys_io        = 0x40000000,
-	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
-	.init_irq       = pxa27x_init_irq,
-	.timer          = &pxa_timer,
-	.init_machine   = e2_init,
-MACHINE_END
+PXA27X_MACHINE(EZX_E2, e2_init, "Motorola EZX E2");
 #endif
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 890fb90..6b6d767 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -72,3 +72,18 @@ void __init pxa_set_ffuart_info(void *info);
 void __init pxa_set_btuart_info(void *info);
 void __init pxa_set_stuart_info(void *info);
 void __init pxa_set_hwuart_info(void *info);
+
+extern struct machine_class machine_class_pxa25x;
+extern struct machine_class machine_class_pxa27x;
+
+#define PXA25X_MACHINE(_type,_init,_name)		\
+MACHINE_START(_type,_name)				\
+	.class		= &machine_class_pxa25x,	\
+	.init_machine	= _init,			\
+}
+
+#define PXA27X_MACHINE(_type,_init,_name)		\
+MACHINE_START(_type,_name)				\
+	.class		= &machine_class_pxa27x,	\
+	.init_machine	= _init,			\
+}
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 848c861..a1b1587 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -869,12 +869,4 @@ static void __init hx4700_init(void)
 	mdelay(10);
 }
 
-MACHINE_START(H4700, "HP iPAQ HX4700")
-	.phys_io      = 0x40000000,
-	.io_pg_offst  = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params  = 0xa0000100,
-	.map_io       = pxa_map_io,
-	.init_irq     = pxa27x_init_irq,
-	.init_machine = hx4700_init,
-	.timer        = &pxa_timer,
-MACHINE_END
+PXA27X_MACHINE_START(H4700, hx4700_init, "HP iPAQ HX4700");
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index e81dd0c..6a86f22 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -764,11 +764,6 @@ static void __init magician_init(void)
 
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-	.phys_io = 0x40000000,
-	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
-	.init_irq = pxa27x_init_irq,
-	.init_machine = magician_init,
-	.timer = &pxa_timer,
+	.class		= &machine_class_pxa27x,
+	.init_machine	= magician_init,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 0b9ad30..8993df6 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -23,6 +23,7 @@
 #include <linux/suspend.h>
 #include <linux/sysdev.h>
 
+#include <asm/mach/arch.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
@@ -341,6 +342,16 @@ static struct sys_device pxa25x_sysdev[] = {
 	},
 };
 
+struct machine_class machine_class_pxa25x __initdata = {
+	.name		= "PXA25x",
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.timer		= &pxa_timer,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+};
+
 static int __init pxa25x_init(void)
 {
 	int i, ret = 0;
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 0af3617..d64b194 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/sysdev.h>
 
+#include <asm/mach/arch.h>
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
@@ -403,6 +404,16 @@ static struct sys_device pxa27x_sysdev[] = {
 	},
 };
 
+struct machine_class machine_class_pxa27x __initdata = {
+	.name		= "PXA27x",
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.timer		= &pxa_timer,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa27x_init_irq,
+};
+
 static int __init pxa27x_init(void)
 {
 	int i, ret = 0;
-- 
1.7.1
