From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 9 Aug 2011 21:41:53 +0200
Subject: [PATCH 5/5] mach-u300: retire AVE device
Message-ID: <1312918913-11960-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We need to face the fact that there will never be a mainlined
driver for the U300 advanced video encoder, so let's just
drop the declaration of this device.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c |   54 ---------------------------------------------
 1 files changed, 0 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index ba0b1d3..5030a45 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -342,51 +342,6 @@ static struct resource wdog_resources[] = {
 	}
 };
 
-/* TODO: These should be protected by suitable #ifdef's */
-static struct resource ave_resources[] = {
-	{
-		.name  = "AVE3e I/O Area",
-		.start = U300_VIDEOENC_BASE,
-		.end   = U300_VIDEOENC_BASE + SZ_512K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "AVE3e IRQ0",
-		.start = IRQ_U300_VIDEO_ENC_0,
-		.end   = IRQ_U300_VIDEO_ENC_0,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "AVE3e IRQ1",
-		.start = IRQ_U300_VIDEO_ENC_1,
-		.end   = IRQ_U300_VIDEO_ENC_1,
-		.flags = IORESOURCE_IRQ,
-	},
-	{
-		.name  = "AVE3e Physmem Area",
-		.start = 0, /* 0 will be remapped to reserved memory */
-		.end   = SZ_1M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	/*
-	 * The AVE3e requires two regions of 256MB that it considers
-	 * "invisible". The hardware will not be able to access these
-	 * addresses, so they should never point to system RAM.
-	 */
-	{
-		.name  = "AVE3e Reserved 0",
-		.start = 0xd0000000,
-		.end   = 0xd0000000 + SZ_256M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.name  = "AVE3e Reserved 1",
-		.start = 0xe0000000,
-		.end   = 0xe0000000 + SZ_256M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
 static struct resource dma_resource[] = {
 	{
 		.start = U300_DMAC_BASE,
@@ -1593,13 +1548,6 @@ static struct platform_device nand_device = {
 	},
 };
 
-static struct platform_device ave_device = {
-	.name = "video_enc",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(ave_resources),
-	.resource = ave_resources,
-};
-
 static struct platform_device dma_device = {
 	.name		= "coh901318",
 	.id		= -1,
@@ -1624,10 +1572,8 @@ static struct platform_device *platform_devs[] __initdata = {
 	&gpio_device,
 	&nand_device,
 	&wdog_device,
-	&ave_device
 };
 
-
 /*
  * Interrupts: the U300 platforms have two pl190 ARM PrimeCells connected
  * together so some interrupts are connected to the first one and some
-- 
1.7.3.2
