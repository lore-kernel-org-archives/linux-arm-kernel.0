From: ramaxlo@gmail.com (Ramax Lo)
Date: Tue, 22 Sep 2009 00:04:16 +0800
Subject: [PATCH] S3C24XX: Define a macro to avoid compilation error
In-Reply-To: <>
References: <>
Message-ID: <1253549056-25322-1-git-send-email-ramaxlo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a macro to avoid the following error during kernel build process
for platforms other than s3c2410:

arch/arm/plat-s3c24xx/cpu.c:84: error: ?s3c2410a_init? undeclared here (not in a function)

Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
---
 arch/arm/plat-s3c24xx/include/plat/s3c2410.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2410.h b/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
index b6deeef..82ab4aa 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
@@ -27,6 +27,7 @@ extern void s3c2410_init_clocks(int xtal);
 #define s3c2410_init_uarts NULL
 #define s3c2410_map_io NULL
 #define s3c2410_init NULL
+#define s3c2410a_init NULL
 #endif
 
 extern int s3c2410_baseclk_add(void);
-- 
1.5.4.3
