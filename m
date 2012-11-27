From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 27 Nov 2012 18:30:35 +0530
Subject: [PATCH 2/3] ARM: exynos5: Add gate clocks for HS-I2C
In-Reply-To: <1354021236-28596-1-git-send-email-ch.naveen@samsung.com>
References: <1354021236-28596-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1354021236-28596-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds clock gating bits for High Speed I2C channels 0, 1, 2 and 3.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 2d3057b..37c6104 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -781,6 +781,26 @@ static struct clk exynos5_init_clocks_off[] = {
 		.enable		= exynos5_clk_ip_peric_ctrl,
 		.ctrlbit	= (1 << 26),
 	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hs-i2c.0",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hs-i2c.1",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hs-i2c.2",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 30),
+	}, {
+		.name		= "hsi2c",
+		.devname	= "exynos5-hs-i2c.3",
+		.enable		= exynos5_clk_ip_peric_ctrl,
+		.ctrlbit	= (1 << 31),
+	}, {
 		.name		= "ac97",
 		.devname	= "samsung-ac97",
 		.enable		= exynos5_clk_ip_peric_ctrl,
-- 
1.7.9.5
