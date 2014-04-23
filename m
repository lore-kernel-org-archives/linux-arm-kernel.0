From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:59:29 +0530
Subject: [PATCH 3/3] dts: exynos5420-smdk5420: Add required VDD regulator
 supplies for usb
In-Reply-To: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
References: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398266969-26000-4-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required VDD 3.3V and VDD 1.0V regulator supplies to usb nodes.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 96d99e1..323ce00 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -185,10 +185,30 @@
 		enable-active-high;
 	};
 
+	usb at 12000000 {
+		vdd33-supply = <&ldo9_reg>;
+		vdd10-supply = <&ldo11_reg>;
+	};
+
 	phy at 12100000 {
 		vbus-supply = <&usb300_vbus_reg>;
 	};
 
+	usb at 12110000 {
+		vdd33-supply = <&ldo9_reg>;
+		vdd10-supply = <&ldo11_reg>;
+	};
+
+	usb at 12120000 {
+		vdd33-supply = <&ldo9_reg>;
+		vdd10-supply = <&ldo11_reg>;
+	};
+
+	usb at 12400000 {
+		vdd33-supply = <&ldo9_reg>;
+		vdd10-supply = <&ldo11_reg>;
+	};
+
 	phy at 12500000 {
 		vbus-supply = <&usb301_vbus_reg>;
 	};
-- 
1.7.10.4
