From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 19:12:01 +0900
Subject: [PATCH 3/6] S5PV210: OneNAND: Define OneNAND IRQ if defined
Message-ID: <20100728101201.GA21341@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Define OneNAND interrupt if defined

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/dev-onenand.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/dev-onenand.c b/arch/arm/plat-s5p/dev-onenand.c
index 4d3eddb..612d166 100644
--- a/arch/arm/plat-s5p/dev-onenand.c
+++ b/arch/arm/plat-s5p/dev-onenand.c
@@ -33,6 +33,13 @@ static struct resource s5pc110_onenand_resources[] = {
 		.end	= S5PC110_PA_ONENAND_DMA + SZ_8K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
+#ifdef IRQ_ONENAND_AUDI
+	[2] = {
+		.start	= IRQ_ONENAND_AUDI,
+		.end	= IRQ_ONENAND_AUDI,
+		.flags	= IORESOURCE_IRQ,
+	},
+#endif
 };
 
 struct platform_device s5pc110_device_onenand = {
-- 
1.5.3.3
