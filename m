From: sbkim73@samsung.com (Sangbeom Kim)
Date: Sat, 26 Feb 2011 11:45:56 +0900
Subject: [PATCH 2/3] ARM: S5P: Update machine initialization for HRT
In-Reply-To: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
References: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1298688357-20775-3-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update mach-s5p64x0 and mach-s5pv210
machine  initialization for hrt support

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5p64x0/mach-smdk6440.c |    4 +++-
 arch/arm/mach-s5p64x0/mach-smdk6450.c |    4 +++-
 arch/arm/mach-s5pv210/mach-aquila.c   |    4 +++-
 arch/arm/mach-s5pv210/mach-goni.c     |    4 +++-
 arch/arm/mach-s5pv210/mach-smdkc110.c |    4 +++-
 arch/arm/mach-s5pv210/mach-smdkv210.c |    4 +++-
 arch/arm/mach-s5pv210/mach-torbreck.c |    4 +++-
 7 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index e5beb84..f967736 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -43,6 +43,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/s5p-time.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -136,6 +137,7 @@ static void __init smdk6440_map_io(void)
 	s5p_init_io(NULL, 0, S5P64X0_SYS_ID);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk6440_uartcfgs, ARRAY_SIZE(smdk6440_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init smdk6440_machine_init(void)
@@ -159,5 +161,5 @@ MACHINE_START(SMDK6440, "SMDK6440")
 	.init_irq	= s5p6440_init_irq,
 	.map_io		= smdk6440_map_io,
 	.init_machine	= smdk6440_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 3a20de0..686ec56 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -43,6 +43,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/s5p-time.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -155,6 +156,7 @@ static void __init smdk6450_map_io(void)
 	s5p_init_io(NULL, 0, S5P64X0_SYS_ID);
 	s3c24xx_init_clocks(19200000);
 	s3c24xx_init_uarts(smdk6450_uartcfgs, ARRAY_SIZE(smdk6450_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init smdk6450_machine_init(void)
@@ -178,5 +180,5 @@ MACHINE_START(SMDK6450, "SMDK6450")
 	.init_irq	= s5p6450_init_irq,
 	.map_io		= smdk6450_map_io,
 	.init_machine	= smdk6450_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 557add4..fab84f3 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -39,6 +39,7 @@
 #include <plat/fb.h>
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define AQUILA_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -664,6 +665,7 @@ static void __init aquila_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(aquila_uartcfgs, ARRAY_SIZE(aquila_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init aquila_machine_init(void)
@@ -698,5 +700,5 @@ MACHINE_START(AQUILA, "Aquila")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 056f5c7..5eda4a1 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -45,6 +45,7 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/clock.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -823,6 +824,7 @@ static void __init goni_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(goni_uartcfgs, ARRAY_SIZE(goni_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init goni_machine_init(void)
@@ -873,5 +875,5 @@ MACHINE_START(GONI, "GONI")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= goni_map_io,
 	.init_machine	= goni_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index ce11a02..f304383 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -30,6 +30,7 @@
 #include <plat/ata.h>
 #include <plat/iic.h>
 #include <plat/pm.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC110_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -111,6 +112,7 @@ static void __init smdkc110_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init smdkc110_machine_init(void)
@@ -138,5 +140,5 @@ MACHINE_START(SMDKC110, "SMDKC110")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index bc9fdb5..41080bf 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -43,6 +43,7 @@
 #include <plat/keypad.h>
 #include <plat/pm.h>
 #include <plat/fb.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -272,6 +273,7 @@ static void __init smdkv210_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init smdkv210_machine_init(void)
@@ -306,5 +308,5 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 043c938..b3516a1 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -27,6 +27,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/iic.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define TORBRECK_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -104,6 +105,7 @@ static void __init torbreck_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(torbreck_uartcfgs, ARRAY_SIZE(torbreck_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init torbreck_machine_init(void)
@@ -127,5 +129,5 @@ MACHINE_START(TORBRECK, "TORBRECK")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= torbreck_map_io,
 	.init_machine	= torbreck_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
-- 
1.7.1
