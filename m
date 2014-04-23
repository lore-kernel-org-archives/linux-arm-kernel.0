From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:59:28 +0530
Subject: [PATCH 2/3] dts: exynos5250-snow: Add required VDD regulator supplies
 for usb
In-Reply-To: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
References: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398266969-26000-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required VDD 3.3V and VDD 1.0V regulator supplies to usb nodes.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index fd9b3b3..21d1f31 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -214,12 +214,24 @@
 		enable-active-high;
 	};
 
+	usb at 12000000 {
+		vdd33-supply = <&ldo12_reg>;
+		vdd10-supply = <&ldo15_reg>;
+	};
+
 	phy at 12100000 {
 		vbus-supply = <&usb3_vbus_reg>;
 	};
 
 	usb at 12110000 {
 		samsung,vbus-gpio = <&gpx1 1 0>;
+		vdd33-supply = <&ldo12_reg>;
+		vdd10-supply = <&ldo15_reg>;
+	};
+
+	usb at 12120000 {
+		vdd33-supply = <&ldo12_reg>;
+		vdd10-supply = <&ldo15_reg>;
 	};
 
 	fixed-rate-clocks {
-- 
1.7.10.4
