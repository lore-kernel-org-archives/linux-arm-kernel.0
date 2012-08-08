From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 08 Aug 2012 09:56:28 +0900
Subject: [PATCH] ARM: EXYNOS: cleanup unused code related to GPS
Message-ID: <0a2e01cd7500$a4765280$ed62f780$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c    |    9 ---------
 arch/arm/mach-exynos/include/mach/map.h |    1 -
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 774533c..3b00e29 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -166,11 +166,6 @@ static int exynos5_clk_ip_gen_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_GEN, clk, enable);
 }
 
-static int exynos5_clk_ip_gps_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_GPS, clk, enable);
-}
-
 static int exynos5_clk_ip_mfc_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(EXYNOS5_CLKGATE_IP_MFC, clk, enable);
@@ -672,10 +667,6 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= exynos5_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
-		.name		= "gps",
-		.enable		= exynos5_clk_ip_gps_ctrl,
-		.ctrlbit	= ((1 << 3) | (1 << 2) | (1 << 0)),
-	}, {
 		.name		= "nfcon",
 		.enable		= exynos5_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 22),
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c72b675..9d1f3ac 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -131,7 +131,6 @@
 #define EXYNOS5_PA_SYSMMU_JPEG		0x11F20000
 #define EXYNOS5_PA_SYSMMU_IOP		0x12360000
 #define EXYNOS5_PA_SYSMMU_RTIC		0x12370000
-#define EXYNOS5_PA_SYSMMU_GPS		0x12630000
 #define EXYNOS5_PA_SYSMMU_ISP		0x13260000
 #define EXYNOS5_PA_SYSMMU_DRC		0x12370000
 #define EXYNOS5_PA_SYSMMU_SCALERC	0x13280000
-- 
1.7.4.1
