From: efremov@linux.com (efremov at linux.com)
Date: Sun, 17 Jun 2018 22:46:17 +0300
Subject: [PATCH] ARM: S3C24XX: fix typo in guard macro for s3c2412.h
Message-ID: <20180617194617.15145-1-efremov@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The guard macro __ARCH_ARM_REGS_S3C24XX_S3C2412_H in header s3c2412.h
doesn't match the #ifndef macro __ARCH_ARM_MACH_S3C24XX_S3C2412_H.
This patch defines the guard correctly.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
index b6b32724ace8..4ff83f956cfb 100644
--- a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
+++ b/arch/arm/mach-s3c24xx/include/mach/s3c2412.h
@@ -6,7 +6,7 @@
  */
 
 #ifndef __ARCH_ARM_MACH_S3C24XX_S3C2412_H
-#define __ARCH_ARM_REGS_S3C24XX_S3C2412_H __FILE__
+#define __ARCH_ARM_MACH_S3C24XX_S3C2412_H __FILE__
 
 #define S3C2412_MEMREG(x)		(S3C24XX_VA_MEMCTRL + (x))
 #define S3C2412_EBIREG(x)		(S3C2412_VA_EBI + (x))
-- 
2.17.1
