From: jg1.han@samsung.com (Jingoo Han)
Date: Sat, 11 May 2013 17:09:11 +0900
Subject: [PATCH] ARM: dts: add pin state information for DP HPD support to
 Exynos5250
Message-ID: <000001ce4e1e$d1cc5de0$756519a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin state information for DP HPD support that requires
pin configuration support using pinctrl interface.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5250

 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |    7 +++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index d1650fb..e9cdee3 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -553,6 +553,13 @@
 			samsung,pin-pud = <0>;
 			samaung,pin-drv = <0>;
 		};
+
+		dp_hpd: dp_hpd {
+			samsung,pins = "gpx0-7";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
 	};
 
 	pinctrl at 13400000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 3e0c792..d53ea34 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -224,6 +224,9 @@
 		samsung,color-depth = <1>;
 		samsung,link-rate = <0x0a>;
 		samsung,lane-count = <4>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_hpd>;
 	};
 
 	display-timings {
-- 
1.7.2.5
