From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 27 Jul 2010 19:39:37 +0900
Subject: [PATCH] S5PC110: Add OneNAND interrupt number
Message-ID: <20100727103937.GA1247@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use OneNAND interrupt at drivers, also extend DMA address to cover fully.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv210/dev-onenand.c b/arch/arm/mach-s5pv210/dev-onenand.c
index 34997b7..f8ede33 100644
--- a/arch/arm/mach-s5pv210/dev-onenand.c
+++ b/arch/arm/mach-s5pv210/dev-onenand.c
@@ -27,9 +27,14 @@ static struct resource s5pc110_onenand_resources[] = {
 	},
 	[1] = {
 		.start	= S5PC110_PA_ONENAND_DMA,
-		.end	= S5PC110_PA_ONENAND_DMA + SZ_2K - 1,
+		.end	= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
+	[2] = {
+		.start	= IRQ_ONENAND_AUDI,
+		.end	= IRQ_ONENAND_AUDI,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 struct platform_device s5pc110_device_onenand = {
