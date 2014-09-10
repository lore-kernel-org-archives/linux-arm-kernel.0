From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 12:19:50 +0200
Subject: [PATCH v3 6/7] ARM: dts: Set i2c7 clock at 400kHz for Peach boards
In-Reply-To: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410344391-5675-7-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The downstream ChromeOS 3.8 kernel sets the clock frequency
for the I2C bus 7 at 400kHz. Do the same change in mainline.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index b8fea56..f247709 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -489,6 +489,7 @@
 
 &hsi2c_7 {
 	status = "okay";
+	clock-frequency = <400000>;
 
 	max98090: codec at 10 {
 		compatible = "maxim,max98090";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 17537f0..88b3544 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -487,6 +487,7 @@
 
 &hsi2c_7 {
 	status = "okay";
+	clock-frequency = <400000>;
 
 	max98091: codec at 10 {
 		compatible = "maxim,max98091";
-- 
2.1.0
