From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 09:06:52 +0200
Subject: [PATCH] ARM: dts: exynos: Enable AX88760 USB hub on Origen board
Message-ID: <1462950412-16681-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Leach <matthew@mattleach.net>

Enable the Origen's usb phy and ohci devices in the device tree.  Also
add the "samsung,vbus-gpio" property to enable the GPX3(5) gpio pin so
the AX88760 hub is powered.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
[k.kozlowski: Extend nodes by label notation instead of path]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-origen.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 8bca699b7f20..4c59bdb0e6f3 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -77,12 +77,29 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
 };
 
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
 
+&exynos_usbphy {
+	status = "okay";
+};
+
+&ehci {
+	samsung,vbus-gpio = <&gpx3 5 1>;
+	status = "okay";
+
+	port at 1{
+		status = "okay";
+	};
+	port at 2 {
+		status = "okay";
+	};
+};
+
 &fimd {
 	pinctrl-0 = <&lcd_clk &lcd_data24 &pwm1_out>;
 	pinctrl-names = "default";
-- 
1.9.1
