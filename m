From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Sep 2010 12:13:48 +0200
Subject: [PATCH] AT91: dm9000 initialization update
Message-ID: <1284113629-13768-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add information in dm9000 mac/phy chip initialization:
- irq resource details
- platform data details

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-sam9261ek.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index c4c8865..b4307ab 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -93,11 +93,12 @@ static struct resource dm9000_resource[] = {
 		.start	= AT91_PIN_PC11,
 		.end	= AT91_PIN_PC11,
 		.flags	= IORESOURCE_IRQ
+			| IORESOURCE_IRQ_LOWEDGE | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
 
 static struct dm9000_plat_data dm9000_platdata = {
-	.flags		= DM9000_PLATF_16BITONLY,
+	.flags		= DM9000_PLATF_16BITONLY | DM9000_PLATF_NO_EEPROM,
 };
 
 static struct platform_device dm9000_device = {
-- 
1.5.6.5
