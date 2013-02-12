From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Feb 2013 01:03:44 +0100
Subject: [PATCH 2/3] ARM: S3C24XX: add soc_is_s3c2412 option
In-Reply-To: <201302120102.03511.heiko@sntech.de>
References: <201302120102.03511.heiko@sntech.de>
Message-ID: <201302120103.44830.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes it possible to identify s3c2412 SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-samsung/include/plat/cpu.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index e126644..0f6c47a 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -23,6 +23,9 @@ extern unsigned long samsung_cpu_id;
 #define S3C24XX_CPU_ID		0x32400000
 #define S3C24XX_CPU_MASK	0xFFF00000
 
+#define S3C2412_CPU_ID		0x32412000
+#define S3C2412_CPU_MASK	0xFFFFF000
+
 #define S3C6400_CPU_ID		0x36400000
 #define S3C6410_CPU_ID		0x36410000
 #define S3C64XX_CPU_MASK	0xFFFFF000
@@ -53,6 +56,7 @@ static inline int is_samsung_##name(void)	\
 }
 
 IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
+IS_SAMSUNG_CPU(s3c2412, S3C2412_CPU_ID, S3C2412_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
@@ -74,6 +78,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_s3c24xx()	0
 #endif
 
+#if defined(CONFIG_CPU_S3C2412)
+# define soc_is_s3c2412()	is_samsung_s3c2412()
+#else
+# define soc_is_s3c2412()	0
+#endif
+
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
 # define soc_is_s3c64xx()	(is_samsung_s3c6400() || is_samsung_s3c6410())
 #else
-- 
1.7.2.3
