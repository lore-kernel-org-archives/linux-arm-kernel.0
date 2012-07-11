From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Wed, 11 Jul 2012 15:12:20 +0530
Subject: [PATCH 6/7] ARM: EXYNOS5: Add the bus clock for FIMD
In-Reply-To: <1341999741-15578-1-git-send-email-l.krishna@samsung.com>
References: <1341999741-15578-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1341999741-15578-7-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leela Krishna <l.krishna@samsung.com>

This patch adds the bus clock for FIMD and changes
the device name for lcd clock

Signed-off-by: Leela Krishna <l.krishna@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index fefa336..61bf88d 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -629,6 +629,11 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= exynos5_clk_ip_disp1_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
+		.name           = "fimd",
+		.devname        = "exynos5-fb",
+		.enable         = exynos5_clk_ip_disp1_ctrl,
+		.ctrlbit        = (1 << 0),
+	}, {
 		.name		= "iis",
 		.devname	= "samsung-i2s.1",
 		.enable		= exynos5_clk_ip_peric_ctrl,
@@ -1046,7 +1051,7 @@ static struct clksrc_clk exynos5_clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "sclk_fimd",
-			.devname	= "s3cfb.1",
+			.devname	= "exynos5-fb",
 			.enable		= exynos5_clksrc_mask_disp1_0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
-- 
1.7.0.4
