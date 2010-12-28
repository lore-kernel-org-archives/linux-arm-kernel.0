From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 28 Dec 2010 20:26:17 +0900
Subject: [PATCH 2/5] S5PC110: add MIPI-DSI clock.
Message-ID: <1293535577-24751-1-git-send-email-inki.dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 019c3a6..58a7c60 100644
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
