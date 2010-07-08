From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 08 Jul 2010 11:36:47 +0900
Subject: [PATCH] s5pc110: Reduce the iodesc length of systimer
Message-ID: <20100708023647.GA8320@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

It's enough to use 4KiB.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..07b86d2 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -41,7 +41,7 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S5P_VA_SYSTIMER,
 		.pfn		= __phys_to_pfn(S5PV210_PA_SYSTIMER),
-		.length		= SZ_1M,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)VA_VIC2,
