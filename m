From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 28 Dec 2012 17:10:50 +0530
Subject: [PATCH 1/2] ARM: exynos5: Add gate clocks for HS-I2C
Message-ID: <1356694851-1345-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds clock gating bits for High Speed I2C channels 0, 1, 2 and 3.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 0208c3a..f9fa0c7 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -753,6 +753,30 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= exynos5_clk_ip_peric_ctrl,
 		.ctrlbit	= (1 << 27),
 	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hsi2c.0",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hsi2c.1",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hsi2c.2",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.ctrlbit	= (1 << 30),
+	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hsi2c.3",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.parent		= &exynos5_clk_aclk_66.clk,
+		.ctrlbit	= (1 << 31),
+	}, {
 		.name		= "usbhost",
 		.enable		= exynos5_clk_ip_fsys_ctrl ,
 		.ctrlbit	= (1 << 18),
-- 
1.7.9.5
