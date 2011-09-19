From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 19 Sep 2011 19:30:40 +0200
Subject: [PATCH v3 3/4] ARM: EXYNOS4: Rename sclk_cam clocks for FIMC driver
In-Reply-To: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
References: <1316453441-13525-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1316453441-13525-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sclk_cam clocks are now controlled by the top level FIMC media
device driver bound to "s5p-fimc-md" platform device.
Rename sclk_cam clocks so they accessible by the corresponding
driver.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index da9567a..a25c818 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -1084,8 +1084,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 28, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_cam",
-			.devname	= "exynos4-fimc.0",
+			.name		= "sclk_cam0",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 16),
 		},
@@ -1094,8 +1093,7 @@ static struct clksrc_clk clksrcs[] = {
 		.reg_div = { .reg = S5P_CLKDIV_CAM, .shift = 16, .size = 4 },
 	}, {
 		.clk		= {
-			.name		= "sclk_cam",
-			.devname	= "exynos4-fimc.1",
+			.name		= "sclk_cam1",
 			.enable		= exynos4_clksrc_mask_cam_ctrl,
 			.ctrlbit	= (1 << 20),
 		},
-- 
1.7.6.3
