From: sangsu4u.park@samsung.com (Sangsu Park)
Date: Fri, 05 Oct 2012 16:37:04 +0900
Subject: [PATCH] ARM: EXYNOS: Remove wrong I2S0 clock from peril clock
Message-ID: <004d01cda2cc$37254570$a56fd050$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove I2S0 clk from peril since peril clock doesn't have I2S0 clk for EXYNOS4.
Audio Subsystem block has I2S0 clk.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos4.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos4.c
b/arch/arm/mach-exynos/clock-exynos4.c
index 6a45c9a..fa8a134 100644
--- a/arch/arm/mach-exynos/clock-exynos4.c
+++ b/arch/arm/mach-exynos/clock-exynos4.c
@@ -613,11 +613,6 @@ static struct clk exynos4_init_clocks_off[] = {
 		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "iis",
-		.devname	= "samsung-i2s.0",
-		.enable		= exynos4_clk_ip_peril_ctrl,
-		.ctrlbit	= (1 << 19),
-	}, {
-		.name		= "iis",
 		.devname	= "samsung-i2s.1",
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 20),
-- 
1.7.9.5
