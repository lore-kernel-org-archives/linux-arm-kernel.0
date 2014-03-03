From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon,  3 Mar 2014 17:02:16 +0100
Subject: [PATCH v2 11/11] ARM: dts: s3c6410-mini6410: Add support for LCD
 screen
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1393862536-9842-12-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds necessary device tree nodes and properties to enable LCD
screen on mini6410 board.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 57e00f9..97f6353 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -167,6 +167,33 @@
 	};
 };
 
+&fimd {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_data24>, <&lcd_power>;
+
+	display-timings {
+		native-mode = <&timing0>;
+
+		timing0: timing at 0 {
+			/* 480x272 at 60Hz */
+			clock-frequency = <10000000>;
+			hactive = <480>;
+			vactive = <272>;
+			hfront-porch = <4>;
+			hback-porch = <45>;
+			hsync-len = <40>;
+			vback-porch = <3>;
+			vfront-porch = <2>;
+			vsync-len = <6>;
+			vsync-active = <1>;
+			hsync-active = <1>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
+	};
+};
+
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
@@ -213,6 +240,12 @@
 				"gpn-4", "gpn-5", "gpl-11", "gpl-12";
 		samsung,pin-pud = <PIN_PULL_NONE>;
 	};
+
+	lcd_power: lcd-power {
+		samsung,pins = "gpe-0";
+		samsung,pin-function = <0>;
+		samsung,pin-pud = <PIN_PULL_UP>;
+	};
 };
 
 &i2c0 {
-- 
1.9.0
