From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 08 May 2014 11:49:55 +0530
Subject: [PATCH v2 5/5] ARM: dts: enable dp-controller for exynos5420 based
 peach-pit board
In-Reply-To: <1399529995-8656-1-git-send-email-rahul.sharma@samsung.com>
References: <1399529995-8656-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1399529995-8656-6-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Enable dp-controller for peach-pit board.

Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |   34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f75da5b..ed76f33 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -74,6 +74,13 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
+
+	dp_hpd: dp_hpd {
+		samsung,pins = "gpx2-6";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
 };
 
 &rtc {
@@ -150,3 +157,30 @@
 	status = "okay";
 	samsung,invert-vclk;
 };
+
+&dp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp_hpd>;
+	samsung,color-space = <0>;
+	samsung,dynamic-range = <0>;
+	samsung,ycbcr-coeff = <0>;
+	samsung,color-depth = <1>;
+	samsung,link-rate = <0x06>;
+	samsung,lane-count = <2>;
+	samsung,hpd-gpio = <&gpx2 6 0>;
+	display-timings {
+		native-mode = <&timing1>;
+		timing1: timing at 1 {
+			clock-frequency = <70589280>;
+			hactive = <1366>;
+			vactive = <768>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <32>;
+			vback-porch = <10>;
+			vfront-porch = <12>;
+			vsync-len = <6>;
+		};
+	};
+};
-- 
1.7.9.5
