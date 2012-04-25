From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:34 +0530
Subject: [PATCH 24/33] ARM: S3C64XX: dev-uart: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-25-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c64xx/dev-uart.c |   48 ++++++-------------------------------
 1 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
index c681b99..46e18d7 100644
--- a/arch/arm/mach-s3c64xx/dev-uart.c
+++ b/arch/arm/mach-s3c64xx/dev-uart.c
@@ -31,55 +31,23 @@
 /* 64xx uarts are closer together */
 
 static struct resource s3c64xx_uart0_resource[] = {
-	[0] = {
-		.start	= S3C_PA_UART0,
-		.end	= S3C_PA_UART0 + 0x100,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART0,
-		.end	= IRQ_UART0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C_PA_UART0, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_UART0),
 };
 
 static struct resource s3c64xx_uart1_resource[] = {
-	[0] = {
-		.start = S3C_PA_UART1,
-		.end   = S3C_PA_UART1 + 0x100,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART1,
-		.end	= IRQ_UART1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C_PA_UART1, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_UART1),
 };
 
 static struct resource s3c6xx_uart2_resource[] = {
-	[0] = {
-		.start = S3C_PA_UART2,
-		.end   = S3C_PA_UART2 + 0x100,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART2,
-		.end	= IRQ_UART2,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C_PA_UART2, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_UART2),
 };
 
 static struct resource s3c64xx_uart3_resource[] = {
-	[0] = {
-		.start = S3C_PA_UART3,
-		.end   = S3C_PA_UART3 + 0x100,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_UART3,
-		.end	= IRQ_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C_PA_UART3, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_UART3),
 };
 
 
-- 
1.7.4.1
