From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 05 Jan 2011 19:34:50 +0900
Subject: [PATCH 1/2] s5pc110: add clock gate for MIPI-DSI controller.
Message-ID: <1294223690-31860-1-git-send-email-inki.dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the clock gate for MIPI-DSI controller is placed at CLK_GATE_IP1[2]
so it adds a clock object to clock framework for MIPI-DSI clock gating.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index dab6ef3..a8d5235 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -365,6 +365,12 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip1_ctrl,
 		.ctrlbit	= (1<<0),
 	}, {
+		.name		= "dsim",
+		.id		= -1,
+		.parent		= &clk_hclk_dsys.clk,
+		.enable		= s5pv210_clk_ip1_ctrl,
+		.ctrlbit	= (1<<2),
+	}, {
 		.name		= "cfcon",
 		.id		= 0,
 		.parent		= &clk_hclk_psys.clk,
-- 
1.7.0.4
