From: dianders@chromium.org (Doug Anderson)
Date: Wed,  8 May 2013 10:37:16 -0700
Subject: [PATCH] ARM: exynos: dts: Fixed vbus-gpios
Message-ID: <1368034636-15865-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'samsung,vbus-gpio' was submitted before pinmux landed for
exynos5250 and uses the old-style gpio specifier.  Fix the two
exynos5250 boards that use it.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +-
 arch/arm/boot/dts/exynos5250-snow.dts     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 26d856b..3e0c792 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -214,7 +214,7 @@
 	};
 
 	usb at 12110000 {
-		samsung,vbus-gpio = <&gpx2 6 1 3 3>;
+		samsung,vbus-gpio = <&gpx2 6 0>;
 	};
 
 	dp-controller {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index bf4744b..d449feb 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -183,7 +183,7 @@
 	};
 
 	usb at 12110000 {
-		samsung,vbus-gpio = <&gpx1 1 1 3 3>;
+		samsung,vbus-gpio = <&gpx1 1 0>;
 	};
 
 	fixed-rate-clocks {
-- 
1.8.2.1
