From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:18 +0800
Subject: [PATCH 12/12] ARM: dts: sun8i: Enable i2c controllers on ippo-q8h-v5
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-13-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c0 is connected to the gsl1680 capacitive touch panel controller.
i2c1 is connected to an mma7660 3-axis accelerometer.
i2c2 is connected to the front and back gc0309 camera sensors.
The camera sensors require additional regulators be enabled before
they are available.

All these peripherals are not supported by the kernel yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
index ef1e4f3..e9b8cca 100644
--- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
+++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
@@ -43,6 +43,25 @@
 			};
 		};
 
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			/* pull-ups and devices require PMIC regulator */
+			status = "failed";
+		};
+
 		r_uart: serial at 01f02800 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&r_uart_pins_a>;
-- 
2.1.0
