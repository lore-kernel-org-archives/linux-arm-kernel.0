From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 11 Apr 2013 13:24:03 +0200
Subject: [PATCH v4 7/7] ARM: mach-shmobile: r8a7740: Setup the timer CMT10
 using DT
In-Reply-To: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
References: <1365679443-25456-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1365679443-25456-7-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now use the Device Tree for bringing up our timer device CMT10 on
the SoC r8a7740.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v4: same. only patch 2 and 3 changed

 arch/arm/mach-shmobile/setup-r8a7740.c |   33 --------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index c2ac4aa..e88b50d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -363,38 +363,6 @@ static struct platform_device scifb_device = {
 	},
 };
 
-/* CMT */
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.channel_offset = 0x10,
-	.timer_bit = 0,
-	.clockevent_rating = 125,
-	.clocksource_rating = 125,
-};
-
-static struct resource cmt10_resources[] = {
-	[0] = {
-		.name	= "CMT10",
-		.start	= 0xe6138010,
-		.end	= 0xe613801b,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_spi(58),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device cmt10_device = {
-	.name		= "sh_cmt",
-	.id		= 10,
-	.dev = {
-		.platform_data	= &cmt10_platform_data,
-	},
-	.resource	= cmt10_resources,
-	.num_resources	= ARRAY_SIZE(cmt10_resources),
-};
-
 /* TMU */
 static struct sh_timer_config tmu00_platform_data = {
 	.name = "TMU00",
@@ -531,7 +499,6 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scifb_device,
-	&cmt10_device,
 	&tmu00_device,
 	&tmu01_device,
 	&tmu02_device,
-- 
1.7.9.5
