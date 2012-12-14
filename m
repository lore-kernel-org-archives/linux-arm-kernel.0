From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 15 Dec 2012 01:13:28 +0900
Subject: [PATCH] ARM: EXYNOS: Fix MSHC clocks instance names
Message-ID: <1355501608-2955-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clock instance name of MSHC controller for BIC and CIU of Exynos4412.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/mach-exynos/clock-exynos4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c b/arch/arm/mach-exynos/clock-exynos4.c
index efead60..bbcb3de 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -529,7 +529,7 @@ static struct clk exynos4_init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
-		.name		= "dwmmc",
+		.name		= "biu",
 		.parent		= &exynos4_clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 9),
@@ -1134,7 +1134,7 @@ static struct clksrc_clk exynos4_clksrcs[] = {
 		.reg_div = { .reg = EXYNOS4_CLKDIV_MFC, .shift = 0, .size = 4 },
 	}, {
 		.clk	= {
-			.name		= "sclk_dwmmc",
+			.name		= "ciu",
 			.parent		= &exynos4_clk_dout_mmc4.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 16),
-- 
1.7.9.5
