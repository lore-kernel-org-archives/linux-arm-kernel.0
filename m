From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 21 May 2014 17:57:22 +0530
Subject: [PATCH] ARM: dts: move dp hpd gpio pin to pinctrl_0 for exynos5420
 peach_pit
Message-ID: <1400675242-7423-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DP Hpd Gpio pin which is "gpx2-6" in Exynos 5420 based peach board,
belongs to Pinctrl_0. It has moved to pinctrl_0 from pinctrl_3.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
Based on Kukjin's for-next branch.

 arch/arm/boot/dts/exynos5420-peach-pit.dts |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index d4127b0..29f64de 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -117,6 +117,13 @@
 		samsung,pin-pud = <1>;
 		samsung,pin-drv = <0>;
 	};
+
+	dp_hpd_gpio: dp_hpd_gpio {
+		samsung,pins = "gpx2-6";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &pinctrl_3 {
@@ -133,13 +140,6 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
-
-	dp_hpd_gpio: dp_hpd_gpio {
-		samsung,pins = "gpx2-6";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
-	};
 };
 
 &rtc {
-- 
1.7.9.5
