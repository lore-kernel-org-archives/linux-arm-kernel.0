From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 21 Nov 2013 15:16:39 -0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Provide a backlight regulator
Message-ID: <1385054199-21400-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without providing the backlight regulator the following error is seen:

pwm-backlight backlight.14: dummy supplies not allowed

,and LVDS screen is blank.

Provide a dummy backlight regulator, so that the LVDS panel can be functional
again.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Tested on linux-next 20131120

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 4239ef9..07206d2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -47,6 +47,15 @@
 			gpio = <&gpio4 10 0>;
 			enable-active-high;
 		};
+
+		reg_backlight: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "lcd-supply";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-always-on;
+		};
 	};
 
 	gpio-keys {
@@ -91,6 +100,7 @@
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
+		power-supply = <&reg_backlight>;
 		status = "okay";
 	};
 };
-- 
1.8.1.2
