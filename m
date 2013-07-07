From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Jul 2013 15:13:31 +0200
Subject: [PATCH 3/3] ARM: dts: imx27 phyCARD-S, i2c ADC device node
In-Reply-To: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
References: <1373202811-13825-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1373202811-13825-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 0514b0a..5a31c77 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -34,6 +34,18 @@
 			};
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3v3: 3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
 };
 
 &fb {
@@ -48,6 +60,12 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	adc at 64 {
+		compatible = "maxim,max1037";
+		vcc-supply = <&reg_3v3>;
+		reg = <0x64>;
+	};
 };
 
 &owire {
-- 
1.8.2.1
