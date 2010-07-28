From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 10:17:32 +0900
Subject: [PATCH] S5PV210/V310: OneNAND: Build only when s5pv210 or s5pv310
	defined
Message-ID: <20100728011732.GA1890@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Build the OneNAND device when s5pv210 and s5pv310 defined

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/dev-onenand.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/dev-onenand.c b/arch/arm/plat-s5p/dev-onenand.c
index 8d191c5..d34b4cb 100644
--- a/arch/arm/plat-s5p/dev-onenand.c
+++ b/arch/arm/plat-s5p/dev-onenand.c
@@ -21,6 +21,7 @@
 #define S5PC110_PA_ONENAND		(0xB0000000)
 #define S5PC110_PA_ONENAND_DMA		(0xB0600000)
 
+#if defined(CONFIG_ARCH_S5PV210) || defined(CONFIG_ARCH_S5PV310)
 static struct resource s5pc110_onenand_resources[] = {
 	[0] = {
 		.start	= S5PC110_PA_ONENAND,
@@ -38,6 +39,7 @@ static struct resource s5pc110_onenand_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 };
+#endif
 
 #ifdef CONFIG_ARCH_S5PV210
 struct platform_device s5pc110_device_onenand = {
-- 
1.5.3.3
