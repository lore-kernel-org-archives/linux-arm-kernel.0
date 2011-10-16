From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 22:57:13 +0200
Subject: [PATCH 8/8] ARM: at91: usart: drop static map regs for dbgu
In-Reply-To: <20111016194504.GK1459@game.jcrosoft.org>
References: <20111016194504.GK1459@game.jcrosoft.org>
Message-ID: <1318798633-2542-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit fb149f9e28354 we introduce ioremap support for static map_io, we do
not need this register entry anymore.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91cap9_devices.c    |    5 ++---
 arch/arm/mach-at91/at91rm9200_devices.c  |    5 ++---
 arch/arm/mach-at91/at91sam9260_devices.c |    5 ++---
 arch/arm/mach-at91/at91sam9261_devices.c |    5 ++---
 arch/arm/mach-at91/at91sam9263_devices.c |    5 ++---
 arch/arm/mach-at91/at91sam9g45_devices.c |    5 ++---
 arch/arm/mach-at91/at91sam9rl_devices.c  |    5 ++---
 7 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index 8f8b96a..06132d9 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -1021,8 +1021,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -1035,7 +1035,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index fdae689..c350ab6 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -877,8 +877,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -891,7 +891,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index b4a292e..3c34a36 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -837,8 +837,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -851,7 +851,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 7057c97..f18a7a9 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -816,8 +816,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -830,7 +830,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 394cbda..6770333 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -1196,8 +1196,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -1210,7 +1210,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 9937582..2b60774 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1332,8 +1332,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -1346,7 +1346,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index bea301c..15d3ed6 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -908,8 +908,8 @@ void __init at91_add_device_ssc(unsigned id, unsigned pins) {}
 #if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
-		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
-		.end	= AT91_VA_BASE_SYS + AT91_DBGU + SZ_512 - 1,
+		.start	= AT91_BASE_SYS + AT91_DBGU,
+		.end	= AT91_BASE_SYS + AT91_DBGU + SZ_512 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -922,7 +922,6 @@ static struct resource dbgu_resources[] = {
 static struct atmel_uart_data dbgu_data = {
 	.use_dma_tx	= 0,
 	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
-	.regs		= (void __iomem *)(AT91_VA_BASE_SYS + AT91_DBGU),
 };
 
 static u64 dbgu_dmamask = DMA_BIT_MASK(32);
-- 
1.7.7
