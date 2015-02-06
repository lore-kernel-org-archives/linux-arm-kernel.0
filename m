From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  6 Feb 2015 18:52:51 +0100
Subject: [PATCH v2 1/1] ARM: dts: Add mclk entry for Snow and Peach Pit/Pi
 boards
Message-ID: <1423245171-25485-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tushar Behera <tushar.b@samsung.com>

On Snow, Peach Pit and Peach Pi boards, the Exynos SoC XCLKOUT output pin
provides the master clock (mclk) to codecs. So make them a clock consumer.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1:
 - Rebased on top of Kukjin's for-next branch since v1 made on top of
   3.19-rc7 doesn't apply cleanly on that branch. Sorry for the noise.

 arch/arm/boot/dts/exynos5250-snow.dts      | 2 ++
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 2 ++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 5be966df7603..6096d6b02dd8 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -206,6 +206,8 @@
 		samsung,model = "Snow-I2S-MAX98095";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98095>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
 	};
 
 	usb3_vbus_reg: regulator-usb3 {
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index ec86d9523935..1d4db3b0676e 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -594,6 +594,8 @@
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98090_irq>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
 	};
 
 	light-sensor at 44 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 06737c60d333..6f2fc3445bd5 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -581,6 +581,8 @@
 		interrupt-parent = <&gpx0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98091_irq>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
 	};
 
 	light-sensor at 44 {
-- 
2.1.3
