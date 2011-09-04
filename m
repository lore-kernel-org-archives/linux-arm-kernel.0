From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon,  5 Sep 2011 00:30:23 +0200
Subject: [PATCH 2/2] s3c2410/gpio-nr.h: fix S3C_GPIO_SPACE #error message to
	match reality
Message-ID: <1315175423-11653-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C_GPIO_SPACE cannont be NON-zero, not zero.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
index 4f7bf32..019ea86 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
@@ -53,7 +53,7 @@
 #define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
 
 #if CONFIG_S3C_GPIO_SPACE != 0
-#error CONFIG_S3C_GPIO_SPACE cannot be zero at the moment
+#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
 #endif
 
 #define S3C2410_GPIO_NEXT(__gpio) \
-- 
1.7.5.4
