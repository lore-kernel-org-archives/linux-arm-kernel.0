From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu,  3 Feb 2011 19:34:50 -0500
Subject: [PATCH 3/3] davinci: dm365: move spi0 eventq assignment from
	resources to platform data
In-Reply-To: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
References: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296779690-9723-4-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the spi0 eventq assignment out of resources array and into platform data.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/dm365.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 02d2cc3..4604e72 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -625,6 +625,7 @@ static u64 dm365_spi0_dma_mask = DMA_BIT_MASK(32);
 static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
+	.dma_event_q	= EVENTQ_3,
 };
 
 static struct resource dm365_spi0_resources[] = {
@@ -645,10 +646,6 @@ static struct resource dm365_spi0_resources[] = {
 		.start = 16,
 		.flags = IORESOURCE_DMA,
 	},
-	{
-		.start = EVENTQ_3,
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct platform_device dm365_spi0_device = {
-- 
1.7.0.4
