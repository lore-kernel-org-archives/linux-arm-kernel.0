From: seanpaul@chromium.org (Sean Paul)
Date: Tue,  5 Feb 2013 15:42:57 -0800
Subject: [PATCH v3 2/3] ARM: Change exynos5-hdmi references to exynos4-hdmi
In-Reply-To: <1360107777-17490-1-git-send-email-seanpaul@chromium.org>
References: <1360107777-17490-1-git-send-email-seanpaul@chromium.org>
Message-ID: <1360107777-17490-3-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the change "drm/exynos: Get HDMI version from device tree",
exynos5-hdmi is no longer relevant. Update references to exynos4-hdmi
and update the hdmi compatibility string to accurately reflect the hdmi
driver.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 arch/arm/boot/dts/exynos5250.dtsi      |    3 ++-
 arch/arm/mach-exynos/clock-exynos5.c   |    4 ++--
 arch/arm/mach-exynos/mach-exynos5-dt.c |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3acf594..70464bf 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -573,7 +573,8 @@
 	};
 
 	hdmi {
-		compatible = "samsung,exynos5-hdmi";
+		compatible = "samsung,exynos5250-hdmi",
+			     "samsung,exynos4212-hdmi", "samsung,exynos4-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
 	};
diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index e9d7b80..6eae39d 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -686,12 +686,12 @@ static struct clk exynos5_init_clocks_off[] = {
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "hdmi",
-		.devname	= "exynos5-hdmi",
+		.devname	= "exynos4-hdmi",
 		.enable		= exynos5_clk_ip_disp1_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "hdmiphy",
-		.devname	= "exynos5-hdmi",
+		.devname	= "exynos4-hdmi",
 		.enable		= exynos5_clk_hdmiphy_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index e99d3d8..0ccda72 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -97,8 +97,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos-gsc.2", NULL),
 	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC3,
 				"exynos-gsc.3", NULL),
-	OF_DEV_AUXDATA("samsung,exynos5-hdmi", 0x14530000,
-				"exynos5-hdmi", NULL),
+	OF_DEV_AUXDATA("samsung,exynos4-hdmi", 0x14530000,
+				"exynos4-hdmi", NULL),
 	OF_DEV_AUXDATA("samsung,exynos5-mixer", 0x14450000,
 				"exynos5-mixer", NULL),
 	OF_DEV_AUXDATA("samsung,mfc-v6", 0x11000000, "s5p-mfc-v6", NULL),
-- 
1.7.7.3
