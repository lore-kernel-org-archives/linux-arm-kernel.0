From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 07:48:07 +0200
Subject: [PATCH 1/3] ARM: s3c24xx: Remove non-existing CONFIG_CPU_S3C2413
Message-ID: <1500270489-14749-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no CONFIG_CPU_S3C2413 so get rid of it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/common.c                  | 2 +-
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h | 4 ++--
 arch/arm/plat-samsung/include/plat/map-s3c.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index b59f4f4f256f..5b6b94ef41e2 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -173,7 +173,7 @@ static unsigned long s3c24xx_read_idcode_v5(void)
 		return gs;
 #endif
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#if defined(CONFIG_CPU_S3C2412)
 	return __raw_readl(S3C2412_GSTATUS1);
 #else
 	return 1UL;	/* don't look like an 2400 */
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
index 3db6c10de023..ae4a3e0f3ba2 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
@@ -77,7 +77,7 @@
 
 #endif /* CONFIG_CPU_S3C2440 or CONFIG_CPU_S3C2442 */
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#if defined(CONFIG_CPU_S3C2412)
 
 #define S3C2412_OSCSET		S3C2410_CLKREG(0x18)
 #define S3C2412_CLKSRC		S3C2410_CLKREG(0x1C)
@@ -141,7 +141,7 @@
 #define S3C2412_CLKSRC_UREFCLK_EXTCLK	(1<<12)
 #define S3C2412_CLKSRC_EREFCLK_EXTCLK	(1<<14)
 
-#endif /* CONFIG_CPU_S3C2412 | CONFIG_CPU_S3C2413 */
+#endif /* CONFIG_CPU_S3C2412 */
 
 #define S3C2416_CLKDIV2		S3C2410_CLKREG(0x28)
 
diff --git a/arch/arm/plat-samsung/include/plat/map-s3c.h b/arch/arm/plat-samsung/include/plat/map-s3c.h
index 6feedd47d875..33104911862e 100644
--- a/arch/arm/plat-samsung/include/plat/map-s3c.h
+++ b/arch/arm/plat-samsung/include/plat/map-s3c.h
@@ -61,7 +61,7 @@
 
 /* deal with the registers that move under the 2412/2413 */
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#if defined(CONFIG_CPU_S3C2412)
 #ifndef __ASSEMBLY__
 extern void __iomem *s3c24xx_va_gpio2;
 #endif
-- 
2.7.4
