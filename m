From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 22 Jun 2011 18:34:11 +0200
Subject: [PATCH 1/2] ARM: S5PV210: Rename sclk_cam clocks for FIMC media driver
In-Reply-To: <1308760452-30676-1-git-send-email-s.nawrocki@samsung.com>
References: <1308760452-30676-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1308760452-30676-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After s5p-fimc driver cvonversion to the media controller API
the sclk_cam clocks are managed by a top level media device driver
bound to "s5p-fimc-md" platform device. Rename sclk_cam clocks
so they can be aquired by the fimc media device.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index b5c95e6..0392f8b 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -844,8 +844,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_cam",
-			.devname	= "s5pv210-fimc.0",
+			.name		= "sclk_cam0",
 			.enable		= s5pv210_clk_mask0_ctrl,
 			.ctrlbit	= (1 << 3),
 		},
@@ -854,8 +853,7 @@ static struct clksrc_clk clksrcs[] = {
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
1.7.5.4
