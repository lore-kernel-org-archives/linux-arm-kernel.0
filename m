From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Apr 2011 20:38:59 +0200
Subject: [PATCH 1/2] at91: 9260 and 9g20 add support of join SRAM Memory
	Mapping
In-Reply-To: <20110415183152.GA10539@game.jcrosoft.org>
References: <20110415183152.GA10539@game.jcrosoft.org>
Message-ID: <1302892740-2010-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 9269 and 9g20 the sram are mirrored at then of the bank so we can join them

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91sam9260.c              |   22 ++++++----------------
 arch/arm/mach-at91/include/mach/at91sam9260.h |    4 ++++
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 195208b..32524ef 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -36,28 +36,18 @@ static struct map_desc at91sam9260_io_desc[] __initdata = {
 
 static struct map_desc at91sam9260_sram_desc[] __initdata = {
 	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM0_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9260_SRAM0_BASE),
-		.length		= AT91SAM9260_SRAM0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM0_SIZE - AT91SAM9260_SRAM1_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9260_SRAM1_BASE),
-		.length		= AT91SAM9260_SRAM1_SIZE,
+		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9260_SRAM_SIZE,
+		.pfn		= __phys_to_pfn(AT91SAM9260_SRAM_BASE),
+		.length		= AT91SAM9260_SRAM_SIZE,
 		.type		= MT_DEVICE,
 	}
 };
 
 static struct map_desc at91sam9g20_sram_desc[] __initdata = {
 	{
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G20_SRAM0_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9G20_SRAM0_BASE),
-		.length		= AT91SAM9G20_SRAM0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G20_SRAM0_SIZE - AT91SAM9G20_SRAM1_SIZE,
-		.pfn		= __phys_to_pfn(AT91SAM9G20_SRAM1_BASE),
-		.length		= AT91SAM9G20_SRAM1_SIZE,
+		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G20_SRAM_SIZE,
+		.pfn		= __phys_to_pfn(AT91SAM9G20_SRAM_BASE),
+		.length		= AT91SAM9G20_SRAM_SIZE,
 		.type		= MT_DEVICE,
 	}
 };
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 4e79036..6c53b95 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -119,6 +119,8 @@
 #define AT91SAM9260_SRAM0_SIZE	SZ_4K		/* Internal SRAM 0 size (4Kb) */
 #define AT91SAM9260_SRAM1_BASE	0x00300000	/* Internal SRAM 1 base address */
 #define AT91SAM9260_SRAM1_SIZE	SZ_4K		/* Internal SRAM 1 size (4Kb) */
+#define AT91SAM9260_SRAM_BASE	0x002FF000	/* Internal SRAM base address */
+#define AT91SAM9260_SRAM_SIZE	SZ_8K		/* Internal SRAM size (8Kb) */
 
 #define AT91SAM9260_UHP_BASE	0x00500000	/* USB Host controller */
 
@@ -132,6 +134,8 @@
 #define AT91SAM9G20_SRAM0_SIZE	SZ_16K		/* Internal SRAM 0 size (16Kb) */
 #define AT91SAM9G20_SRAM1_BASE	0x00300000	/* Internal SRAM 1 base address */
 #define AT91SAM9G20_SRAM1_SIZE	SZ_16K		/* Internal SRAM 1 size (16Kb) */
+#define AT91SAM9G20_SRAM_BASE	0x002FC000	/* Internal SRAM base address */
+#define AT91SAM9G20_SRAM_SIZE	SZ_32K		/* Internal SRAM size (32Kb) */
 
 #define AT91SAM9G20_UHP_BASE	0x00500000	/* USB Host controller */
 
-- 
1.7.4.1
