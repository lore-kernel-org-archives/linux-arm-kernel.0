From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 13 Apr 2011 21:43:17 +0200
Subject: [PATCH] at91/board-eco920: remove at91_beeper ressource as no driver
	at91_beeper exist
Message-ID: <1302723797-25760-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-eco920.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-at91/board-eco920.c b/arch/arm/mach-at91/board-eco920.c
index a1e9173..104e19b 100644
--- a/arch/arm/mach-at91/board-eco920.c
+++ b/arch/arm/mach-at91/board-eco920.c
@@ -86,21 +86,6 @@ static struct platform_device eco920_flash = {
 	.num_resources  = 1,
 };
 
-static struct resource at91_beeper_resources[] = {
-	[0] = {
-		.start          = AT91RM9200_BASE_TC3,
-		.end            = AT91RM9200_BASE_TC3 + 0x39,
-		.flags          = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device at91_beeper = {
-	.name           = "at91_beeper",
-	.id             = 0,
-	.resource       = at91_beeper_resources,
-	.num_resources  = ARRAY_SIZE(at91_beeper_resources),
-};
-
 static struct spi_board_info eco920_spi_devices[] = {
 	{	/* CAN controller */
 		.modalias	= "tlv5638",
@@ -139,10 +124,6 @@ static void __init eco920_board_init(void)
 		AT91_SMC_TDF_(1)	/* float time */
 	);
 
-	at91_clock_associate("tc3_clk", &at91_beeper.dev, "at91_beeper");
-	at91_set_B_periph(AT91_PIN_PB6, 0);
-	platform_device_register(&at91_beeper);
-
 	at91_add_device_spi(eco920_spi_devices, ARRAY_SIZE(eco920_spi_devices));
 }
 
-- 
1.7.4.1
