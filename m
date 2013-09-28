From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 28 Sep 2013 20:21:36 +0200
Subject: [PATCH 4/5] ASoC: samsung: Use CONFIG_ARCH_S3C64XX to check for
 S3C64xx support
In-Reply-To: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1380392497-27406-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
the s3c-i2s-v2 driver to use the proper way of checking for S3C64xx
support - CONFIG_ARCH_S3C64XX.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 sound/soc/samsung/s3c-i2s-v2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index e5e81b1..fefc561 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -31,11 +31,7 @@
 #undef S3C_IIS_V2_SUPPORTED
 
 #if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
-	|| defined(CONFIG_CPU_S5PV210)
-#define S3C_IIS_V2_SUPPORTED
-#endif
-
-#ifdef CONFIG_PLAT_S3C64XX
+	|| defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_CPU_S5PV210)
 #define S3C_IIS_V2_SUPPORTED
 #endif
 
-- 
1.8.3.2
