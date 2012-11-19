From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 19 Nov 2012 15:46:34 +0100
Subject: [PATCH 2/4] ARM: dts: exynos4210-origen: Update for pinctrl-samsung
 driver
In-Reply-To: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
References: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353336396-21161-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates all parts of Origen dts related to pin configuration
to use new GPIO and pinctrl bindings, instead of (now unsupported on
Exynos4) legacy gpio-samsung bindings.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-origen.dts | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 392d9de..2eb1332 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -36,13 +36,8 @@
 		samsung,sdhci-bus-width = <4>;
 		linux,mmc_cap_4_bit_data;
 		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk2 2 2 3 3>;
-		gpios = <&gpk2 0 2 0 3>,
-			<&gpk2 1 2 0 3>,
-			<&gpk2 3 2 3 3>,
-			<&gpk2 4 2 3 3>,
-			<&gpk2 5 2 3 3>,
-			<&gpk2 6 2 3 3>;
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sd2_cd>;
+		pinctrl-names = "default";
 		status = "okay";
 	};
 
@@ -50,13 +45,8 @@
 		samsung,sdhci-bus-width = <4>;
 		linux,mmc_cap_4_bit_data;
 		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk0 2 2 3 3>;
-		gpios = <&gpk0 0 2 0 3>,
-			<&gpk0 1 2 0 3>,
-			<&gpk0 3 2 3 3>,
-			<&gpk0 4 2 3 3>,
-			<&gpk0 5 2 3 3>,
-			<&gpk0 6 2 3 3>;
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_cd>;
+		pinctrl-names = "default";
 		status = "okay";
 	};
 
@@ -83,35 +73,35 @@
 
 		up {
 			label = "Up";
-			gpios = <&gpx2 0 0 0x10000 2>;
+			gpios = <&gpx2 0 1>;
 			linux,code = <103>;
 			gpio-key,wakeup;
 		};
 
 		down {
 			label = "Down";
-			gpios = <&gpx2 1 0 0x10000 2>;
+			gpios = <&gpx2 1 1>;
 			linux,code = <108>;
 			gpio-key,wakeup;
 		};
 
 		back {
 			label = "Back";
-			gpios = <&gpx1 7 0 0x10000 2>;
+			gpios = <&gpx1 7 1>;
 			linux,code = <158>;
 			gpio-key,wakeup;
 		};
 
 		home {
 			label = "Home";
-			gpios = <&gpx1 6 0 0x10000 2>;
+			gpios = <&gpx1 6 1>;
 			linux,code = <102>;
 			gpio-key,wakeup;
 		};
 
 		menu {
 			label = "Menu";
-			gpios = <&gpx1 5 0 0x10000 2>;
+			gpios = <&gpx1 5 1>;
 			linux,code = <139>;
 			gpio-key,wakeup;
 		};
@@ -120,7 +110,7 @@
 	leds {
 		compatible = "gpio-leds";
 		status {
-			gpios = <&gpx1 3 0 0x10000 2>;
+			gpios = <&gpx1 3 1>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
1.8.0
