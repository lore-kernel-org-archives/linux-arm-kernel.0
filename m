From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri,  1 Aug 2014 06:54:52 +0200
Subject: [PATCH v5 05/10] ARM: dts: Move dp_hpd from exynos5250 into smdk5250
 and snow
In-Reply-To: <1406868897-26874-1-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
Message-ID: <1406868897-26874-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spring uses a different GPIO, so this is not a generic SoC piece.

Suggested-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v5: New (Tomasz Figa)
 Frees dp_hpd for Spring.

 arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 7 -------
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 9 +++++++++
 arch/arm/boot/dts/exynos5250-snow.dts     | 7 +++++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 886cfca044ac..ed0e5230514b 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -581,13 +581,6 @@
 			samsung,pin-pud = <0>;
 			samsung,pin-drv = <0>;
 		};
-
-		dp_hpd: dp_hpd {
-			samsung,pins = "gpx0-7";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
-		};
 	};
 
 	pinctrl at 13400000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index aaa055ac0fe3..5d30fe1dcda4 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -414,3 +414,12 @@
 		};
 	};
 };
+
+&pinctrl_0 {
+	dp_hpd: dp_hpd {
+		samsung,pins = "gpx0-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index c4b0c73c736d..a9a2f2743794 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -547,6 +547,13 @@
 };
 
 &pinctrl_0 {
+	dp_hpd: dp_hpd {
+		samsung,pins = "gpx0-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	ec_irq: ec-irq {
 		samsung,pins = "gpx1-6";
 		samsung,pin-function = <0>;
-- 
1.9.3
