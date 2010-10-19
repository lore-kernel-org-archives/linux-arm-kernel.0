From: jassi.brar@samsung.com (Jassi Brar)
Date: Tue, 19 Oct 2010 15:27:54 +0900
Subject: [PATCH 01/26] ARM: S5PC100: Debug clock sources
Message-ID: <1287469674-10425-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio, Keypad and ADC inherit PCLKD1 clock source.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index be14d4e..8958bde 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -679,55 +679,55 @@ static struct clk init_clocks_disable[] = {
 	}, {
 		.name		= "iis",
 		.id		= 0,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "iis",
 		.id		= 1,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "iis",
 		.id		= 2,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "ac97",
 		.id		= -1,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "pcm",
 		.id		= 0,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "pcm",
 		.id		= 1,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "spdif",
 		.id		= -1,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "adc",
 		.id		= -1,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "keypad",
 		.id		= -1,
-		.parent		= &clk_div_d1_bus.clk,
+		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
-- 
1.6.2.5
