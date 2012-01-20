From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:27:49 +0000
Subject: [PATCH 16/31] ARM: amba: u300: get rid of NO_IRQ initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAlB-0005FL-Pi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-u300/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index b4c6926..ed92967 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -105,7 +105,7 @@ static struct amba_device uart0_device = {
 		.end   = U300_UART0_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = { IRQ_U300_UART0, NO_IRQ },
+	.irq = { IRQ_U300_UART0 },
 };
 
 /* The U335 have an additional UART1 on the APP CPU */
@@ -129,7 +129,7 @@ static struct amba_device uart1_device = {
 		.end   = U300_UART1_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = { IRQ_U300_UART1, NO_IRQ },
+	.irq = { IRQ_U300_UART1 },
 };
 #endif
 
@@ -160,7 +160,7 @@ static struct amba_device pl022_device = {
 		.end   = U300_SPI_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_U300_SPI, NO_IRQ },
+	.irq = {IRQ_U300_SPI },
 	/*
 	 * This device has a DMA channel but the Linux driver does not use
 	 * it currently.
-- 
1.7.4.4
