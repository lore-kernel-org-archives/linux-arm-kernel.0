From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:42 +0000
Subject: [PATCH 01/12] ARM: S3C24XX: Define a macro to avoid compilation error
Message-ID: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ramax Lo <ramaxlo@gmail.com>

Define a macro to avoid the following error during kernel build process
for platforms other than s3c2410:

arch/arm/plat-s3c24xx/cpu.c:84: error: ?s3c2410a_init? undeclared here (not in a function)

Signed-off-by: Ramax Lo <ramaxlo@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
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
1.6.3.3
