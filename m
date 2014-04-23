From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:59:27 +0530
Subject: [PATCH 1/3] dts: exynos5250: Add required VDD regulator supplies for
 usb
In-Reply-To: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
References: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398266969-26000-2-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required VDD 3.3V and VDD 1.0V regulator supplies to usb nodes.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a794a70..2f183b8 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -363,8 +363,20 @@
 		samsung,audio-codec = <&wm8994>;
 	};
 
+	usb at 12000000 {
+		vdd33-supply = <&ldo12_reg>;
+		vdd10-supply = <&ldo15_reg>;
+	};
+
 	usb at 12110000 {
 		samsung,vbus-gpio = <&gpx2 6 0>;
+		vdd33-supply = <&ldo12_reg>;
+		vdd10-supply = <&ldo15_reg>;
+	};
+
+	usb at 12120000 {
+		vdd33-supply = <&ldo12_reg>;
+		vdd10-supply = <&ldo15_reg>;
 	};
 
 	dp-controller at 145B0000 {
-- 
1.7.10.4
