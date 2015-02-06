From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  6 Feb 2015 17:55:47 +0100
Subject: [PATCH 1/1] ARM: dts: Add mclk entry for Snow and Peach Pit/Pi boards
Message-ID: <1423241747-15032-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tushar Behera <tushar.b@samsung.com>

On Snow, Peach Pit and Peach Pi boards, the Exynos SoC XCLKOUT output pin
provides the master clock (mclk) to codecs. So make them a clock consumer.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts      | 2 ++
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 2 ++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index fc64a0066325..ece8bdb40c0a 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -191,6 +191,8 @@
 		samsung,model = "DAISYI2S";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98095>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
 	};
 
 	usb3_vbus_reg: regulator-usb3 {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index c9a0e170a0f0..30014e6c6799 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -491,6 +491,8 @@
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98090_irq>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
 	};
 
 	light-sensor at 44 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index a80ceeac4ec8..a415ad88bc0c 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -490,6 +490,8 @@
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98091_irq>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
 	};
 
 	light-sensor at 44 {
-- 
2.1.3
