From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  4 Jul 2011 10:41:45 +0900
Subject: [PATCH 4/6] ARM: EXYNOS4: SYSMMU: add devname in SYSMMU clock to
	support clkdev.
In-Reply-To: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
References: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1309743708-1505-5-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 'devname' memeber to clk structure definition for
System MMUs. Use of 'name' member of clk structure is obsolete anymore.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos4/clock.c      |   15 +++++++++++++++
 arch/arm/mach-exynos4/dev-sysmmu.c |    2 +-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index ecbe87b..7d9fbeb 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -628,62 +628,77 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 13),
 	}, {
 		.name		= "SYSMMU_SSS",
+		.devname	= "s5p-sysmmu.0",
 		.enable		= exynos4_clk_ip_dmc_ctrl,
 		.ctrlbit	= (1 << 12),
 	}, {
 		.name		= "SYSMMU_FIMC0",
+		.devname	= "s5p-sysmmu.1",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "SYSMMU_FIMC1",
+		.devname	= "s5p-sysmmu.2",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 8),
 	}, {
 		.name		= "SYSMMU_FIMC2",
+		.devname	= "s5p-sysmmu.3",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 9),
 	}, {
 		.name		= "SYSMMU_FIMC3",
+		.devname	= "s5p-sysmmu.4",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "SYSMMU_JPEG",
+		.devname	= "s5p-sysmmu.5",
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 11),
 	}, {
 		.name		= "SYSMMU_FIMD0",
+		.devname	= "s5p-sysmmu.6",
 		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_FIMD1",
+		.devname	= "s5p-sysmmu.7",
 		.enable		= exynos4_clk_ip_lcd1_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_PCIe",
+		.devname	= "s5p-sysmmu.8",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 18),
 	}, {
 		.name		= "SYSMMU_G2D",
+		.devname	= "s5p-sysmmu.9",
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
 		.name		= "SYSMMU_ROTATOR",
+		.devname	= "s5p-sysmmu.10",
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_MDMA",
+		.devname	= "s5p-sysmmu.11",
 		.enable		= exynos4_clk_ip_image_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "SYSMMU_TV",
+		.devname	= "s5p-sysmmu.12",
 		.enable		= exynos4_clk_ip_tv_ctrl,
 		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "SYSMMU_MFC_L",
+		.devname	= "s5p-sysmmu.13",
 		.enable		= exynos4_clk_ip_mfc_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "SYSMMU_MFC_R",
+		.devname	= "s5p-sysmmu.14",
 		.enable		= exynos4_clk_ip_mfc_ctrl,
 		.ctrlbit	= (1 << 2),
 	}
diff --git a/arch/arm/mach-exynos4/dev-sysmmu.c b/arch/arm/mach-exynos4/dev-sysmmu.c
index 5da8a4c..824a079 100644
--- a/arch/arm/mach-exynos4/dev-sysmmu.c
+++ b/arch/arm/mach-exynos4/dev-sysmmu.c
@@ -103,7 +103,7 @@ struct platform_device exynos4_device_sysmmu[S5P_SYSMMU_TOTAL_IPNUM] = {
 static struct clk *sysmmu_clk[S5P_SYSMMU_TOTAL_IPNUM];
 void sysmmu_clk_init(struct device *dev, sysmmu_ips ips)
 {
-	sysmmu_clk[ips] = clk_get(dev, sysmmu_ips_name[ips]);
+	sysmmu_clk[ips] = clk_get(dev, NULL);
 	if (IS_ERR(sysmmu_clk[ips]))
 		sysmmu_clk[ips] = NULL;
 	else
-- 
1.7.1
