From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu,  3 Feb 2011 19:34:49 -0500
Subject: [PATCH 2/3] davinci: dm355: move spi0 eventq assignment from
	resources to platform data
In-Reply-To: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
References: <1296779690-9723-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296779690-9723-3-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the eventq assignment for spi0 out of resources and into platform data.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/dm355.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a5f8a80..76364d1 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -403,16 +403,13 @@ static struct resource dm355_spi0_resources[] = {
 		.start = 16,
 		.flags = IORESOURCE_DMA,
 	},
-	{
-		.start = EVENTQ_1,
-		.flags = IORESOURCE_DMA,
-	},
 };
 
 static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.cshold_bug	= true,
+	.dma_event_q	= EVENTQ_1,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
-- 
1.7.0.4
