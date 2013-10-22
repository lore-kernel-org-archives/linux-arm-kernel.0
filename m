From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:07 +0530
Subject: [PATCH v2 6/7] ARM: dts: update hdmiphy dt node for exynos5250
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-7-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmiphy dt node needs a child node called 'phy-power-control'
which represents the PMU register for power controlling the
hdmiphy.

hdmi driver dt node provides phy property which points to
the hdmiphy dt node.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 49f18c2..99a83412 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -134,9 +134,15 @@
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 
-		hdmiphy at 38 {
+		hdmiphy: hdmiphy at 38 {
 			compatible = "samsung,exynos4212-hdmiphy";
 			reg = <0x38>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			phy-power-control {
+				reg = <0x10040700 0x04>;
+			};
 		};
 	};
 
@@ -220,6 +226,7 @@
 
 	hdmi {
 		hpd-gpio = <&gpx3 7 0>;
+		phy = <&hdmiphy>;
 	};
 
 	codec at 11000000 {
-- 
1.7.10.4
