From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 12 May 2014 12:15:19 +0530
Subject: [PATCH 1/2] ARM: dts: enable display controller for exynos5800 based
 peach-pi board
In-Reply-To: <1399877120-4634-1-git-send-email-rahul.sharma@samsung.com>
References: <1399877120-4634-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1399877120-4634-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable display controller with timing information for 1080p
panel in Exynos5800 peach-pi board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts |   36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 742655b..426705a 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -72,6 +72,13 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
+
+	dp_hpd_gpio: dp_hpd_gpio {
+		samsung,pins = "gpx2-6";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &rtc {
@@ -121,6 +128,35 @@
 	};
 };
 
+&dp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp_hpd_gpio>;
+	samsung,color-space = <0>;
+	samsung,dynamic-range = <0>;
+	samsung,ycbcr-coeff = <0>;
+	samsung,color-depth = <1>;
+	samsung,link-rate = <0x0a>;
+	samsung,lane-count = <2>;
+	samsung,hpd-gpio = <&gpx2 6 0>;
+
+	display-timings {
+		native-mode = <&timing1>;
+
+		timing1: timing at 1 {
+			clock-frequency = <150660000>;
+			hactive = <1920>;
+			vactive = <1080>;
+			hfront-porch = <60>;
+			hback-porch = <172>;
+			hsync-len = <80>;
+			vback-porch = <25>;
+			vfront-porch = <10>;
+			vsync-len = <10>;
+		};
+	};
+};
+
 &hsi2c_9 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.7.9.5
