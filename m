From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Nov 2013 16:50:33 +0100
Subject: [RFC PATCH 3/3] ARM: cfa10057: Add the accelerometer and gyroscope to
 the device tree
In-Reply-To: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1384876234-1211-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CFA-10057 has an embedded ST Micro LSM330 DLC accelerometer and
gyroscope wired on the the i2c0 bus. Add those to the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10057.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 0333c0532f28..fc289465c30f 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -119,6 +119,19 @@
 				status = "okay";
 			};
 
+			i2c0: i2c at 80058000 {
+				accel: accel at 19 {
+					compatible = "st,lsm330dlc-accel";
+					reg = <0x19>;
+				};
+
+				gyro: gyro at 6a {
+					compatible = "st,lsm330dlc-gyro";
+					reg = <0x6a>;
+				};
+			};
+
+
 			i2c1: i2c at 8005a000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c1_pins_a>;
-- 
1.8.4.2
