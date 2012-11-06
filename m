From: nicolas@eukrea.com (Nicolas Royer)
Date: Tue,  6 Nov 2012 17:31:03 +0100
Subject: [PATCH 1/5] ARM: AT91SAM9G45: fix crypto peripherals irq issue due to
 sparse irq support.
Message-ID: <1352219463-30360-1-git-send-email-nicolas@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spare irq support introduced by commit "8fe82a5 ARM: at91: sparse irq support"
involves to add the NR_IRQS_LEGACY offset to irq number.

Signed-off-by: Nicolas Royer <nicolas@eukrea.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Eric B?nard <eric@eukrea.com>
Tested-by: Eric B?nard <eric@eukrea.com>
Cc: stable at vger.kernel.org # 3.6
---
 arch/arm/mach-at91/at91sam9g45_devices.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index b159607..fcd233c 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1841,8 +1841,8 @@ static struct resource sha_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91SAM9G45_ID_AESTDESSHA,
-		.end	= AT91SAM9G45_ID_AESTDESSHA,
+		.start	= NR_IRQS_LEGACY + AT91SAM9G45_ID_AESTDESSHA,
+		.end	= NR_IRQS_LEGACY + AT91SAM9G45_ID_AESTDESSHA,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -1874,8 +1874,8 @@ static struct resource tdes_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91SAM9G45_ID_AESTDESSHA,
-		.end	= AT91SAM9G45_ID_AESTDESSHA,
+		.start	= NR_IRQS_LEGACY + AT91SAM9G45_ID_AESTDESSHA,
+		.end	= NR_IRQS_LEGACY + AT91SAM9G45_ID_AESTDESSHA,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -1910,8 +1910,8 @@ static struct resource aes_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= AT91SAM9G45_ID_AESTDESSHA,
-		.end	= AT91SAM9G45_ID_AESTDESSHA,
+		.start	= NR_IRQS_LEGACY + AT91SAM9G45_ID_AESTDESSHA,
+		.end	= NR_IRQS_LEGACY + AT91SAM9G45_ID_AESTDESSHA,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.6.5
