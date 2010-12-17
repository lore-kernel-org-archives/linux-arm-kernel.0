From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:06 +0900
Subject: [PATCH 04/17] ARM: S5P6450: Define clocks for I2S
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562006-19716-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Define missing controller clocks for the I2S-0,1 blocks.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6450.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 7fc6abd..d8b20ee 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -261,6 +261,18 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 26),
 	}, {
+		.name		= "iis",
+		.id		= 1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 15),
+	}, {
+		.name		= "iis",
+		.id		= 2,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 16),
+	}, {
 		.name		= "i2c",
 		.id		= 1,
 		.parent		= &clk_pclk_low.clk,
-- 
1.6.2.5
