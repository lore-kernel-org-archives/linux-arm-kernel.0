From: jagan@openedev.com (Jagan Teki)
Date: Fri, 24 Mar 2017 21:48:36 +0530
Subject: [PATCH v2 01/15] ARM: dts: imx6ul-geam: Add backlight support for
 lcdif
In-Reply-To: <1490372330-5611-1-git-send-email-jagan@openedev.com>
References: <1490372330-5611-1-git-send-email-jagan@openedev.com>
Message-ID: <1490372330-5611-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

This patch add support for lcdif backlight on GEAM6UL
variant boards.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm/boot/dts/imx6ul-geam.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-geam.dtsi b/arch/arm/boot/dts/imx6ul-geam.dtsi
index 940aef6..ee5220c 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dtsi
+++ b/arch/arm/boot/dts/imx6ul-geam.dtsi
@@ -49,6 +49,23 @@
 		reg = <0x80000000 0x08000000>;
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm8 0 100000>;
+		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
+				     10 11 12 13 14 15 16 17 18 19
+				     20 21 22 23 24 25 26 27 28 29
+				     30 31 32 33 34 35 36 37 38 39
+				     40 41 42 43 44 45 46 47 48 49
+				     50 51 52 53 54 55 56 57 58 59
+				     60 61 62 63 64 65 66 67 68 69
+				     70 71 72 73 74 75 76 77 78 79
+				     80 81 82 83 84 85 86 87 88 89
+				     90 91 92 93 94 95 96 97 98 99
+				    100>;
+		default-brightness-level = <100>;
+	};
+
 	chosen {
 		stdout-path = &uart1;
 	};
@@ -143,6 +160,12 @@
 	display = <&display0>;
 };
 
+&pwm8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm8>;
+	status = "okay";
+};
+
 &tsc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tsc>;
@@ -290,6 +313,12 @@
 		>;
 	};
 
+	pinctrl_pwm8: pwm8grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
+		>;
+	};
+
 	pinctrl_tsc: tscgrp {
 		fsl,pin = <
 			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
-- 
1.9.1
