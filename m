From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 May 2010 11:30:49 +0200
Subject: [PATCH 2/2] ARM: SMDKC100: remove magic values from uart setup
	structures
In-Reply-To: <1274175049-21847-1-git-send-email-m.szyprowski@samsung.com>
References: <1274175049-21847-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274175049-21847-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces nice defines for the initial values for UART devices
on SMDKC100.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/mach-smdkc100.c |   40 ++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index dd8c154..3a7dc3e 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -44,38 +44,48 @@
 #include <plat/fb.h>
 #include <plat/iic.h>
 
-#define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
-#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
-#define UFCON (S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define S5PC100_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define S5PC100_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S3C2440_UFCON_RXTRIG8 |	\
+				 S3C2440_UFCON_TXTRIG16)
 
 static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 	[0] = {
 		.hwport	     = 0,
 		.flags	     = 0,
-		.ucon	     = 0x3c5,
-		.ulcon	     = 0x03,
-		.ufcon	     = 0x51,
+		.ucon	     = S5PC100_UCON_DEFAULT,
+		.ulcon	     = S5PC100_ULCON_DEFAULT,
+		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[1] = {
 		.hwport	     = 1,
 		.flags	     = 0,
-		.ucon	     = 0x3c5,
-		.ulcon	     = 0x03,
-		.ufcon	     = 0x51,
+		.ucon	     = S5PC100_UCON_DEFAULT,
+		.ulcon	     = S5PC100_ULCON_DEFAULT,
+		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[2] = {
 		.hwport	     = 2,
 		.flags	     = 0,
-		.ucon	     = 0x3c5,
-		.ulcon	     = 0x03,
-		.ufcon	     = 0x51,
+		.ucon	     = S5PC100_UCON_DEFAULT,
+		.ulcon	     = S5PC100_ULCON_DEFAULT,
+		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 	[3] = {
 		.hwport	     = 3,
 		.flags	     = 0,
-		.ucon	     = 0x3c5,
-		.ulcon	     = 0x03,
-		.ufcon	     = 0x51,
+		.ucon	     = S5PC100_UCON_DEFAULT,
+		.ulcon	     = S5PC100_ULCON_DEFAULT,
+		.ufcon	     = S5PC100_UFCON_DEFAULT,
 	},
 };
 
-- 
1.6.4
