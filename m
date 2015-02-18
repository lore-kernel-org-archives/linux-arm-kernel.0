From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 17:17:25 +0100
Subject: [PATCH] ARM: dts: Update lid and power pin-functions for
 exynos5250-spring
Message-ID: <1424276245-7028-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the pins in external interrupt mode, as done for Snow in
e5e5c6d14e39 ("ARM: dts: Add power and lid GPIO keys pinctrl for
exynos5250-snow").

Reported-by: Kukjin Kim <kgene@kernel.org>
Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Fixes: 53dd4138bb0a ("ARM: dts: Add exynos5250-spring device tree")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5250-spring.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index c41600e587e0..d075a68ac078 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -482,7 +482,7 @@
 
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-3";
-		samsung,pin-function = <0>;
+		samsung,pin-function = <0xf>;
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
@@ -510,7 +510,7 @@
 
 	lid_irq: lid-irq {
 		samsung,pins = "gpx3-5";
-		samsung,pin-function = <0>;
+		samsung,pin-function = <0xf>;
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
-- 
2.1.4
