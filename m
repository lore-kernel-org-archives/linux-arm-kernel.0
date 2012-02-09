From: ts.srikanth@samsung.com (srikanth)
Date: Thu, 09 Feb 2012 15:24:54 +0900
Subject: [PATCH 1/3] ARM: EXYNOS: SATA clock config update
Message-ID: <004701cce6f3$899a3d50$9cceb7f0$%srikanth@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA clock configuration update.

Signed-off-by: Srikanth TS <ts.srikanth@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index b0c4478..739a4d6 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -902,6 +902,16 @@ static struct clksrc_clk exynos5_clksrcs[] = {
 		.reg_div = { .reg = EXYNOS5_CLKDIV_TOP0, .shift = 24, .size = 3 },
 	}, {
 		.clk	= {
+			.name		= "sclk_sata",
+			.devname	= "ahci",
+			.enable		= exynos5_clk_ip_fsys_ctrl,
+			.ctrlbit	= (1 << 24),
+		},
+		.sources = &exynos5_clkset_aclk,
+		.reg_src = { .reg = EXYNOS5_CLKSRC_FSYS, .shift = 24, .size = 1 },
+		.reg_div = { .reg = EXYNOS5_CLKDIV_FSYS0, .shift = 20, .size = 4 },
+	}, {
+		.clk	= {
 			.name		= "sclk_gscl_wrap",
 			.devname	= "s5p-mipi-csis.0",
 			.enable		= exynos5_clksrc_mask_gscl_ctrl,
-- 
1.7.1
