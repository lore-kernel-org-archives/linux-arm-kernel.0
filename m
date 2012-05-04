From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 04 May 2012 18:17:40 +0200
Subject: [PATCH] ARM: EXYNOS: Add platform resource definitions for FIMC-LITE
Message-ID: <1336148260-19952-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the gate clocks and register region address definition for
FIMC-LITE devices available in Exynos4x12 and Exynos5 SoCs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos4212.c |   10 ++++++++++
 arch/arm/mach-exynos/include/mach/map.h |    3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
index 9882312..da397d2 100644
--- a/arch/arm/mach-exynos/clock-exynos4212.c
+++ b/arch/arm/mach-exynos/clock-exynos4212.c
@@ -92,6 +92,16 @@ static struct clk init_clocks_off[] = {
 		.devname	= SYSMMU_CLOCK_DEVNAME(isp, 9),
 		.enable		= exynos4212_clk_ip_isp1_ctrl,
 		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "flite",
+		.devname	= "exynos-fimc-lite.0",
+		.enable		= exynos4212_clk_ip_isp0_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "flite",
+		.devname	= "exynos-fimc-lite.1",
+		.enable		= exynos4212_clk_ip_isp0_ctrl,
+		.ctrlbit	= (1 << 3),
 	}
 };
 
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 0e2292d..d30643b 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -34,6 +34,9 @@
 
 #define EXYNOS4_PA_JPEG			0x11840000
 
+/* x = 0...1 */
+#define EXYNOS4_PA_FIMC_LITE(x)		(0x12390000 + ((x) * 0x10000))
+
 #define EXYNOS4_PA_G2D			0x12800000
 
 #define EXYNOS4_PA_I2S0			0x03830000
-- 
1.7.10
