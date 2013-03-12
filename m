From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 01:42:49 +0100
Subject: [PATCH 2/7] ARM: S3C24XX: add soc_is_s3c2416 and soc_is_s3c2443
In-Reply-To: <201303120141.31262.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
Message-ID: <201303120142.49757.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to distinguish between them during at least the clock init.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/include/plat/cpu.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 989fefe..33dad1c 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -26,6 +26,12 @@ extern unsigned long samsung_cpu_id;
 #define S3C2412_CPU_ID		0x32412000
 #define S3C2412_CPU_MASK	0xFFFFF000
 
+#define S3C2416_CPU_ID		0x32450000
+#define S3C2416_CPU_MASK	0xFFFFF000
+
+#define S3C2443_CPU_ID		0x32443000
+#define S3C2443_CPU_MASK	0xFFFFF000
+
 #define S3C6400_CPU_ID		0x36400000
 #define S3C6410_CPU_ID		0x36410000
 #define S3C64XX_CPU_MASK	0xFFFFF000
@@ -57,6 +63,8 @@ static inline int is_samsung_##name(void)	\
 
 IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c2412, S3C2412_CPU_ID, S3C2412_CPU_MASK)
+IS_SAMSUNG_CPU(s3c2416, S3C2416_CPU_ID, S3C2416_CPU_MASK)
+IS_SAMSUNG_CPU(s3c2443, S3C2443_CPU_ID, S3C2443_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
@@ -84,6 +92,18 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_s3c2412()	0
 #endif
 
+#if defined(CONFIG_CPU_S3C2416)
+# define soc_is_s3c2416()	is_samsung_s3c2416()
+#else
+# define soc_is_s3c2416()	0
+#endif
+
+#if defined(CONFIG_CPU_S3C2443)
+# define soc_is_s3c2443()	is_samsung_s3c2443()
+#else
+# define soc_is_s3c2443()	0
+#endif
+
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
 # define soc_is_s3c64xx()	(is_samsung_s3c6400() || is_samsung_s3c6410())
 #else
-- 
1.7.2.3
