From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  4 Jul 2011 10:41:43 +0900
Subject: [PATCH 2/6] ARM: EXYNOS4: SYSMMU: Enable clock gating for System MMU
	of SSS
In-Reply-To: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
References: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1309743708-1505-3-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock gating of SYSMMU_SSS that was missing is added.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 256b46b..ecbe87b 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -154,6 +154,11 @@ static int exynos4_clk_audss_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_AUDSS, clk, enable);
 }
 
+static int exynos4_clk_ip_dmc_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_DMC, clk, enable);
+}
+
 /* Core list of CMU_CPU side */
 
 static struct clksrc_clk clk_mout_apll = {
@@ -622,6 +627,10 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
+		.name		= "SYSMMU_SSS",
+		.enable		= exynos4_clk_ip_dmc_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
 		.name		= "SYSMMU_FIMC0",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 7),
-- 
1.7.1
