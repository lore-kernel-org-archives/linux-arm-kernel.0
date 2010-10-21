From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 09:58:31 +0900
Subject: [PATCH 3/5] ARM: S5P64X0: Set DMA clock disable as default
In-Reply-To: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1287622713-1657-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Seungwhan Youn <sw.youn@samsung.com>

This patch modify to DMA operation clock into disable list for default
clock setting.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Acked-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |   12 ++++++------
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index 0d728d3..e4883dc 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -153,6 +153,12 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
+		.name		= "pdma",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_hclk_low.clk,
@@ -334,12 +340,6 @@ static struct clk init_clocks[] = {
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
-		.name		= "dma",
-		.id		= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p64x0_hclk0_ctrl,
-		.ctrlbit	= (1 << 12),
-	}, {
 		.name		= "uart",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 1b9b0f9..7dbf3c9 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -189,6 +189,12 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
+		.name		= "pdma",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_hclk_low.clk,
@@ -286,12 +292,6 @@ static struct clk init_clocks[] = {
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 21),
 	}, {
-		.name		= "dma",
-		.id		= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p64x0_hclk0_ctrl,
-		.ctrlbit	= (1 << 12),
-	}, {
 		.name		= "uart",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
-- 
1.6.2.5
