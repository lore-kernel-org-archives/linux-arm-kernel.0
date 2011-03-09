From: sbkim73@samsung.com (Sangbeom Kim)
Date: Wed,  9 Mar 2011 11:13:32 +0900
Subject: [PATCH v4 2/3] ARM: S5P: Update machine initialization for HRT
In-Reply-To: <1299636813-4869-1-git-send-email-sbkim73@samsung.com>
References: <1299636813-4869-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1299636813-4869-3-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update mach-s5p64x0 and mach-s5pv210
machine  initialization for hrt support.
Except smdkv210, PWM Timer3 is used for default clockevent.
And PWM Timer4 is used for defualt clocksource.
In the SMDKV210, clockevent is used PMW Timer2.

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
index 366dca4..2d559f1 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -45,6 +45,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/s5p-time.h>
 
 #define SMDK6440_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -179,6 +180,7 @@ static void __init smdk6440_map_io(void)
 	s5p_init_io(NULL, 0, S5P64X0_SYS_ID);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(smdk6440_uartcfgs, ARRAY_SIZE(smdk6440_uartcfgs));
+	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
 }
 
 static void __init smdk6440_machine_init(void)
@@ -202,5 +204,5 @@ MACHINE_START(SMDK6440, "SMDK6440")
 	.init_irq	= s5p6440_init_irq,
 	.map_io		= smdk6440_map_io,
 	.init_machine	= smdk6440_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 1d8f9fd..d19c469 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -45,6 +45,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/s5p-time.h>
 
 #define SMDK6450_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
 				S3C2410_UCON_RXILEVEL |		\
@@ -198,6 +199,7 @@ static void __init smdk6450_map_io(void)
 	s5p_init_io(NULL, 0, S5P64X0_SYS_ID);
 	s3c24xx_init_clocks(19200000);
 	s3c24xx_init_uarts(smdk6450_uartcfgs, ARRAY_SIZE(smdk6450_uartcfgs));
+	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
 }
 
 static void __init smdk6450_machine_init(void)
@@ -221,5 +223,5 @@ MACHINE_START(SMDK6450, "SMDK6450")
 	.init_irq	= s5p6450_init_irq,
 	.map_io		= smdk6450_map_io,
 	.init_machine	= smdk6450_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index e5acb36..4e1d8ff 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -39,6 +39,7 @@
 #include <plat/fb.h>
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define AQUILA_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -646,6 +647,7 @@ static void __init aquila_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(aquila_uartcfgs, ARRAY_SIZE(aquila_uartcfgs));
+	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
 }
 
 static void __init aquila_machine_init(void)
@@ -680,5 +682,5 @@ MACHINE_START(AQUILA, "Aquila")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= aquila_map_io,
 	.init_machine	= aquila_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index a431742..2432917 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -45,6 +45,7 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/clock.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define GONI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -835,6 +836,7 @@ static void __init goni_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(goni_uartcfgs, ARRAY_SIZE(goni_uartcfgs));
+	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
 }
 
 static void __init goni_machine_init(void)
@@ -888,5 +890,5 @@ MACHINE_START(GONI, "GONI")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= goni_map_io,
 	.init_machine	= goni_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index ce11a02..6c412c8 100644
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
+	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
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
index 2b5f488..1032071 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -45,6 +45,7 @@
 #include <plat/pm.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
+#include <plat/s5p-time.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -315,6 +316,7 @@ static void __init smdkv210_map_io(void)
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
 	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
+	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
 
 static void __init smdkv210_machine_init(void)
@@ -349,5 +351,5 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_timer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 043c938..925fc0d 100644
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
+	s5p_set_timer_source(S5P_PWM3, S5P_PWM4);
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
