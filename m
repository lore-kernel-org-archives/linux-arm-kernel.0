From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Sep 2014 12:19:49 +0200
Subject: [PATCH v3 5/7] ARM: dts: Add Peach Pit and Pi dts entry for ISL29018
 sensor
In-Reply-To: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1410344391-5675-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 based Peach Pit and the Exynos5800 based Peach Pi
machines have an i2c ISL29018 light sensor. This patch adds the
device nodes needed to support this device.

These DTS snippets were taken from the downstream Chrome OS 3.8
kernel Device Tree for Peach Pit and Pi boards.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 6 ++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 07115b7..b8fea56 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -498,6 +498,12 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98090_irq>;
 	};
+
+	light-sensor at 44 {
+		compatible = "isil,isl29018";
+		reg = <0x44>;
+		vcc-supply = <&tps65090_fet5>;
+	};
 };
 
 &hsi2c_9 {
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 1c128e1..17537f0 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -496,6 +496,12 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98091_irq>;
 	};
+
+	light-sensor at 44 {
+		compatible = "isil,isl29018";
+		reg = <0x44>;
+		vcc-supply = <&tps65090_fet5>;
+	};
 };
 
 &hsi2c_9 {
-- 
2.1.0
