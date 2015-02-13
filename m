From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 13 Feb 2015 15:12:04 +0100
Subject: [PATCH 4/5] ARM: dts: imx28-apf28dev: add support for can0
In-Reply-To: <1423836725-86061-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1423836725-86061-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1423836725-86061-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1423836725-86061-4-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
Signed-off-by: Sebastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 68405c3..a052d3e 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -110,6 +110,13 @@
 					};
 				};
 			};
+
+			can0: can at 80032000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&can0_pins_a>;
+				xceiver-supply = <&reg_can0_vcc>;
+				status = "okay";
+			};
 		};
 
 		apbx at 80040000 {
@@ -176,6 +183,14 @@
 			gpio = <&gpio1 23 1>;
 			enable-active-high;
 		};
+
+		reg_can0_vcc: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "can0_vcc";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
 	};
 
 	leds {
-- 
2.0.5
