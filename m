From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 19 Sep 2011 19:30:38 +0200
Subject: [PATCH v3 1/4] ARM: S5PV210: Rename sclk_cam clocks for FIMC media
	driver
In-Reply-To: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
References: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1316453441-13525-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sclk_cam clocks are now controlled by the top level FIMC media
device driver bound to "s5p-fimc-md" platform device.
Rename sclk_cam clocks so they accessible by the corresponding
driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index ad553ee..4c5ac7a 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -879,8 +879,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_cam",
-			.devname	= "s5pv210-fimc.0",
+			.name		= "sclk_cam0",
 			.enable		= s5pv210_clk_mask0_ctrl,
 			.ctrlbit	= (1 << 3),
 		},
@@ -889,8 +888,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_cam",
-			.devname	= "s5pv210-fimc.1",
+			.name		= "sclk_cam1",
 			.enable		= s5pv210_clk_mask0_ctrl,
 			.ctrlbit	= (1 << 4),
 		},
-- 
1.7.6.3
