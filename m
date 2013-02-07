From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 7 Feb 2013 22:50:57 +0100
Subject: [PATCH 2/2] ARM: S3C24XX: cleanup the included soc init functions in
 common.h
In-Reply-To: <201302072249.04263.heiko@sntech.de>
References: <201302072249.04263.heiko@sntech.de>
Message-ID: <201302072250.57275.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the _init, _init_clocks, _init_uarts and _map_io functions need
NULL defines, as they are used in the cpu map.

Further integrate the two restart functions already in common.h in
their respective soc part and compact the numerous empty lines.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.h |   47 ++++-----------------------------------
 1 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 4db3dd8..8a2b413 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -12,17 +12,15 @@
 #ifndef __ARCH_ARM_MACH_S3C24XX_COMMON_H
 #define __ARCH_ARM_MACH_S3C24XX_COMMON_H __FILE__
 
-#ifdef CONFIG_CPU_S3C2410
+struct s3c2410_uartcfg;
 
+#ifdef CONFIG_CPU_S3C2410
 extern  int s3c2410_init(void);
 extern  int s3c2410a_init(void);
-
 extern void s3c2410_map_io(void);
-
 extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
 extern void s3c2410_init_clocks(int xtal);
-
+extern void s3c2410_restart(char mode, const char *cmd);
 #else
 #define s3c2410_init_clocks NULL
 #define s3c2410_init_uarts NULL
@@ -32,61 +30,41 @@ extern void s3c2410_init_clocks(int xtal);
 #endif
 
 #ifdef CONFIG_CPU_S3C2412
-
 extern  int s3c2412_init(void);
-
 extern void s3c2412_map_io(void);
-
 extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
 extern void s3c2412_init_clocks(int xtal);
-
 extern  int s3c2412_baseclk_add(void);
-
 extern void s3c2412_restart(char mode, const char *cmd);
 #else
 #define s3c2412_init_clocks NULL
 #define s3c2412_init_uarts NULL
 #define s3c2412_map_io NULL
 #define s3c2412_init NULL
-#define s3c2412_restart NULL
 #endif
 
 #ifdef CONFIG_CPU_S3C2416
-
-struct s3c2410_uartcfg;
-
 extern  int s3c2416_init(void);
-
 extern void s3c2416_map_io(void);
-
 extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
 extern void s3c2416_init_clocks(int xtal);
-
 extern  int s3c2416_baseclk_add(void);
-
 extern void s3c2416_restart(char mode, const char *cmd);
-
 extern void s3c2416_init_irq(void);
-extern struct syscore_ops s3c2416_irq_syscore_ops;
 
+extern struct syscore_ops s3c2416_irq_syscore_ops;
 #else
 #define s3c2416_init_clocks NULL
 #define s3c2416_init_uarts NULL
 #define s3c2416_map_io NULL
 #define s3c2416_init NULL
-#define s3c2416_restart NULL
 #endif
 
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
-
 extern void s3c244x_map_io(void);
-
 extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
 extern void s3c244x_init_clocks(int xtal);
-
+extern void s3c244x_restart(char mode, const char *cmd);
 #else
 #define s3c244x_init_clocks NULL
 #define s3c244x_init_uarts NULL
@@ -94,7 +72,6 @@ extern void s3c244x_init_clocks(int xtal);
 
 #ifdef CONFIG_CPU_S3C2440
 extern  int s3c2440_init(void);
-
 extern void s3c2440_map_io(void);
 #else
 #define s3c2440_init NULL
@@ -103,7 +80,6 @@ extern void s3c2440_map_io(void);
 
 #ifdef CONFIG_CPU_S3C2442
 extern  int s3c2442_init(void);
-
 extern void s3c2442_map_io(void);
 #else
 #define s3c2442_init NULL
@@ -111,33 +87,20 @@ extern void s3c2442_map_io(void);
 #endif
 
 #ifdef CONFIG_CPU_S3C2443
-
-struct s3c2410_uartcfg;
-
 extern  int s3c2443_init(void);
-
 extern void s3c2443_map_io(void);
-
 extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
 extern void s3c2443_init_clocks(int xtal);
-
 extern  int s3c2443_baseclk_add(void);
-
 extern void s3c2443_restart(char mode, const char *cmd);
-
 extern void s3c2443_init_irq(void);
 #else
 #define s3c2443_init_clocks NULL
 #define s3c2443_init_uarts NULL
 #define s3c2443_map_io NULL
 #define s3c2443_init NULL
-#define s3c2443_restart NULL
 #endif
 
-void s3c2410_restart(char mode, const char *cmd);
-void s3c244x_restart(char mode, const char *cmd);
-
 extern struct syscore_ops s3c24xx_irq_syscore_ops;
 
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
-- 
1.7.2.3
