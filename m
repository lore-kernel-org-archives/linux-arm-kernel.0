From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 20 Aug 2014 13:19:53 +0200
Subject: [PATCH v2 5/5] ARM: dts: Add Peach Pit and Pi dts entry for ISL29018
 sensor
In-Reply-To: <1408533593-32346-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1408533593-32346-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1408533593-32346-6-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Exynos5420 based Peach Pit and the Exynos5800 based Peach Pi
machines have an i2c ISL29018 light sensor. This patch adds the
device nodes needed to support this device.

These DTS snippets were taken from the downstream Chrome OS 3.8
kernel Device Tree for Peach Pit and Pi boards.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 6 ++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 94225e6..455bfb8 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -499,6 +499,12 @@
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
index 8f9d66e..03bbe79 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -497,6 +497,12 @@
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
2.0.1
