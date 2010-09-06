From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 05:50:41 +0200
Subject: [PATCH 1/4] ARM: S5PC110: add fimc clocks.
In-Reply-To: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1283745044-15514-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clocks enables FIMC driver to operate on machines, which bootloader
power gated FIMC devices to save power on boot.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index af91fef..9c199ef 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -281,6 +281,24 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip0_ctrl,
 		.ctrlbit	= (1<<29),
 	}, {
+		.name		= "fimc",
+		.id		= 0,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 24),
+	}, {
+		.name		= "fimc",
+		.id		= 1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 25),
+	}, {
+		.name		= "fimc",
+		.id		= 2,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
 		.name		= "otg",
 		.id		= -1,
 		.parent		= &clk_hclk_psys.clk,
-- 
1.7.2.2
