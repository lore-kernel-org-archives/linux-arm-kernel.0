From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Sep 2012 17:13:04 +0200
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
In-Reply-To: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1348758784-15245-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
GPIO expander eventually.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index bf0b05b..d26ddf2 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -76,6 +76,30 @@
 				status = "okay";
 			};
 
+			i2cmux {
+				compatible = "i2c-mux-gpio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
+				i2c-parent = <&i2c1>;
+
+				i2c at 0 {
+					reg = <0>;
+				};
+
+				i2c at 1 {
+					reg = <1>;
+				};
+
+				i2c at 2 {
+					reg = <2>;
+				};
+
+				i2c at 3 {
+					reg = <3>;
+				};
+			};
+
 			usbphy1: usbphy at 8007e000 {
 				status = "okay";
 			};
-- 
1.7.9.5
