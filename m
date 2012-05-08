From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 8 May 2012 20:40:20 +0200
Subject: [PATCH v2 06/33] ARM: S3C24XX: dev-uart: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-7-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
 <1335327163-11794-7-git-send-email-tushar.behera@linaro.org>
Message-ID: <201205082040.20900.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tushar Behera <tushar.behera@linaro.org>

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v1: update the patch to apply against the moved dev-uart devices
As this patch does not touch anything else apart from the uart devices it could
also be applied on top of the movement patches directly

 arch/arm/mach-s3c24xx/common.c |   56 +++++++++++----------------------------
 1 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index d42423a..56cdd34 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -241,55 +241,31 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 /* Serial port registrations */
 
 static struct resource s3c2410_uart0_resource[] = {
-	[0] = {
-		.start = S3C2410_PA_UART0,
-		.end   = S3C2410_PA_UART0 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX0,
-		.end   = IRQ_S3CUART_ERR0,
-		.flags = IORESOURCE_IRQ,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_PA_UART0, SZ_16K),
+	[1] = DEFINE_RES_NAMED(IRQ_S3CUART_RX0, \
+			IRQ_S3CUART_ERR0 - IRQ_S3CUART_RX0 + 1, \
+			NULL, IORESOURCE_IRQ)
 };
 
 static struct resource s3c2410_uart1_resource[] = {
-	[0] = {
-		.start = S3C2410_PA_UART1,
-		.end   = S3C2410_PA_UART1 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX1,
-		.end   = IRQ_S3CUART_ERR1,
-		.flags = IORESOURCE_IRQ,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_PA_UART1, SZ_16K),
+	[1] = DEFINE_RES_NAMED(IRQ_S3CUART_RX1, \
+			IRQ_S3CUART_ERR1 - IRQ_S3CUART_RX1 + 1, \
+			NULL, IORESOURCE_IRQ)
 };
 
 static struct resource s3c2410_uart2_resource[] = {
-	[0] = {
-		.start = S3C2410_PA_UART2,
-		.end   = S3C2410_PA_UART2 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX2,
-		.end   = IRQ_S3CUART_ERR2,
-		.flags = IORESOURCE_IRQ,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_PA_UART2, SZ_16K),
+	[1] = DEFINE_RES_NAMED(IRQ_S3CUART_RX2, \
+			IRQ_S3CUART_ERR2 - IRQ_S3CUART_RX2 + 1, \
+			NULL, IORESOURCE_IRQ)
 };
 
 static struct resource s3c2410_uart3_resource[] = {
-	[0] = {
-		.start = S3C2443_PA_UART3,
-		.end   = S3C2443_PA_UART3 + 0x3fff,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_S3CUART_RX3,
-		.end   = IRQ_S3CUART_ERR3,
-		.flags = IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C2443_PA_UART3, SZ_16K),
+	[1] = DEFINE_RES_NAMED(IRQ_S3CUART_RX3, \
+			IRQ_S3CUART_ERR3 - IRQ_S3CUART_RX3 + 1, \
+			NULL, IORESOURCE_IRQ)
 };
 
 struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
-- 
1.7.5.4
