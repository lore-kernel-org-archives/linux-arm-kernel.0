From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Fri, 21 Sep 2012 18:29:56 +0530
Subject: [PATCH V2 2/3] ARM: EXYNOS: add device tree based discovery support
 for FIMD
In-Reply-To: <1348232397-2477-1-git-send-email-l.krishna@samsung.com>
References: <1348232397-2477-1-git-send-email-l.krishna@samsung.com>
Message-ID: <1348232397-2477-3-git-send-email-l.krishna@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for device tree based discovery for Samsung's
display controller. Adds DRM-Fimd plat data for smdk5250
evt1 to the corresponding dts file

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   15 +++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    2 ++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 8a5e348..2ebf993 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -109,4 +109,19 @@
 	spi_2: spi at 12d40000 {
 		status = "disabled";
 	};
+
+	lcd_fimd0: lcd_panel0 {
+			lcd-htiming = <4 4 4 1280>;
+			lcd-vtiming = <4 4 4 800>;
+	};
+
+	fimd {
+		samsung,fimd-display = <&lcd_fimd0>;
+		samsung,fimd-vidout-rgb;
+		samsung,fimd-inv-vclk;
+		samsung,fimd-frame-rate = <60>;
+		samsung,default-window = <0>;
+		samsung,fimd-win-bpp = <32>;
+	};
+
 };
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 5aa77f9..76b4a68 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -174,6 +174,7 @@
 #define EXYNOS4_PA_MIPI_CSIS1		0x11890000
 
 #define EXYNOS4_PA_FIMD0		0x11C00000
+#define EXYNOS5_PA_FIMD1		0x14400000
 
 #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 #define EXYNOS4_PA_DWMCI		0x12550000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index e707eb1..5fd5068 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -64,6 +64,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos-gsc.2", NULL),
 	OF_DEV_AUXDATA("samsung,exynos5-gsc", EXYNOS5_PA_GSC3,
 				"exynos-gsc.3", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5-fimd", EXYNOS5_PA_FIMD1,
+				"exynos5-fb.1", NULL),
 	{},
 };
 
-- 
1.7.0.4
