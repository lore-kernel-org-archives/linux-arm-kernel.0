From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:33 +0900
Subject: [PATCH 01/10] S3C64XX I2S: S3C64XX_PA_IISV4 defined
Message-ID: <1253008953-10441-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defined the missing S3C64XX_PA_IISV4 conditionally for 6410 as
it's not avaialble for 6400

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6400/include/mach/map.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index 5057d99..775577a 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -44,6 +44,9 @@
 #define S3C64XX_PA_SYSCON	(0x7E00F000)
 #define S3C64XX_PA_IIS0		(0x7F002000)
 #define S3C64XX_PA_IIS1		(0x7F003000)
+#ifdef CONFIG_CPU_S3C6410
+#define S3C64XX_PA_IISV4	(0x7F00D000)
+#endif
 #define S3C64XX_PA_TIMER	(0x7F006000)
 #define S3C64XX_PA_IIC0		(0x7F004000)
 #define S3C64XX_PA_IIC1		(0x7F00F000)
-- 
1.6.2.5
