From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:30:30 +0000
Subject: [PATCH 24/31] ARM: amba: ep93xx: use common amba device initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAnm-0005Fu-Pc@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ep93xx/core.c |   46 +++++-------------------------------------
 1 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 1a8397a..903edb0 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -279,48 +279,14 @@ static struct amba_pl010_data ep93xx_uart_data = {
 	.set_mctrl	= ep93xx_uart_set_mctrl,
 };
 
-static struct amba_device uart1_device = {
-	.dev		= {
-		.init_name	= "apb:uart1",
-		.platform_data	= &ep93xx_uart_data,
-	},
-	.res		= {
-		.start	= EP93XX_UART1_PHYS_BASE,
-		.end	= EP93XX_UART1_PHYS_BASE + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_EP93XX_UART1 },
-	.periphid	= 0x00041010,
-};
-
-static struct amba_device uart2_device = {
-	.dev		= {
-		.init_name	= "apb:uart2",
-		.platform_data	= &ep93xx_uart_data,
-	},
-	.res		= {
-		.start	= EP93XX_UART2_PHYS_BASE,
-		.end	= EP93XX_UART2_PHYS_BASE + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_EP93XX_UART2 },
-	.periphid	= 0x00041010,
-};
+static AMBA_APB_DEVICE(uart1, "apb:uart1", 0x00041010, EP93XX_UART1_PHYS_BASE,
+	{ IRQ_EP93XX_UART1 }, &ep93xx_uart_data);
 
-static struct amba_device uart3_device = {
-	.dev		= {
-		.init_name	= "apb:uart3",
-		.platform_data	= &ep93xx_uart_data,
-	},
-	.res		= {
-		.start	= EP93XX_UART3_PHYS_BASE,
-		.end	= EP93XX_UART3_PHYS_BASE + 0x0fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { IRQ_EP93XX_UART3 },
-	.periphid	= 0x00041010,
-};
+static AMBA_APB_DEVICE(uart2, "apb:uart2", 0x00041010, EP93XX_UART2_PHYS_BASE,
+	{ IRQ_EP93XX_UART2 }, &ep93xx_uart_data);
 
+static AMBA_APB_DEVICE(uart3, "apb:uart3", 0x00041010, EP93XX_UART3_PHYS_BASE,
+	{ IRQ_EP93XX_UART3 }, &ep93xx_uart_data);
 
 static struct resource ep93xx_rtc_resource[] = {
 	{
-- 
1.7.4.4
