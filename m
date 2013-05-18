From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 19 May 2013 00:37:02 +0200
Subject: [PATCH 1/6] watchdog: s3c2410_wdt: Use local register definitions
In-Reply-To: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1368916627-23139-2-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves register and bitfield definitions to the driver itself,
removing remaining dependencies on plat/ and mach/ headers.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/watchdog/s3c2410_wdt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index ee03135..3a9f696 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -42,12 +42,21 @@
 #include <linux/err.h>
 #include <linux/of.h>
 
-#include <mach/map.h>
+#define S3C2410_WTCON		0x00
+#define S3C2410_WTDAT		0x04
+#define S3C2410_WTCNT		0x08
 
-#undef S3C_VA_WATCHDOG
-#define S3C_VA_WATCHDOG (0)
+#define S3C2410_WTCON_RSTEN	(1 << 0)
+#define S3C2410_WTCON_INTEN	(1 << 2)
+#define S3C2410_WTCON_ENABLE	(1 << 5)
 
-#include <plat/regs-watchdog.h>
+#define S3C2410_WTCON_DIV16	(0 << 3)
+#define S3C2410_WTCON_DIV32	(1 << 3)
+#define S3C2410_WTCON_DIV64	(2 << 3)
+#define S3C2410_WTCON_DIV128	(3 << 3)
+
+#define S3C2410_WTCON_PRESCALE(x)	((x) << 8)
+#define S3C2410_WTCON_PRESCALE_MASK	(0xff << 8)
 
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
-- 
1.8.2.1
