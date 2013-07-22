From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Jul 2013 01:49:21 +0200
Subject: [PATCH v2 4/8] ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
In-Reply-To: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1374536965-3545-5-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds soc_is_s3c6400() and soc_is_s3c6410() macros that allow
to distinguish between specific SoCs from s3c64xx series that is needed
to handle differences between them.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/plat-samsung/include/plat/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 4fb1f03..335beb3 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -87,8 +87,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 #endif
 
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
+# define soc_is_s3c6400()	is_samsung_s3c6400()
+# define soc_is_s3c6410()	is_samsung_s3c6410()
 # define soc_is_s3c64xx()	(is_samsung_s3c6400() || is_samsung_s3c6410())
 #else
+# define soc_is_s3c6400()	0
+# define soc_is_s3c6410()	0
 # define soc_is_s3c64xx()	0
 #endif
 
-- 
1.8.3.2
