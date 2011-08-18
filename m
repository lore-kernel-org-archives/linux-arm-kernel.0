From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 18 Aug 2011 15:43:48 +0900
Subject: [PATCH] ARM: S5P64X0: Add the devname for DMA clock
Message-ID: <1313649828-27642-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devname for DMA clock.
NOTE: This patch should be added after merging new pl330 driver on dmaengine.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |    1 +
 arch/arm/mach-s5p64x0/clock-s5p6450.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index c1f548f..c54c65d 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -147,6 +147,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "dma",
+		.devname	= "dma-pl330",
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 12),
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 3d9b609..2d04abf 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -180,6 +180,7 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "dma",
+		.devname	= "dma-pl330",
 		.parent		= &clk_hclk_low.clk,
 		.enable		= s5p64x0_hclk0_ctrl,
 		.ctrlbit	= (1 << 12),
-- 
1.7.1
