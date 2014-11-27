From: tremyfr@gmail.com (Philippe Reynes)
Date: Thu, 27 Nov 2014 21:33:59 +0100
Subject: [PATCH] apf27dev: add max5821 to the dts
Message-ID: <1417120439-11784-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27-apf27dev.dts |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index da306c5..bba3f41 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -59,6 +59,21 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_max5821: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "max5821-reg";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+	};
 };
 
 &cspi1 {
@@ -107,6 +122,12 @@
 		compatible = "dallas,ds1374";
 		reg = <0x68>;
 	};
+
+	max5821 at 38 {
+		compatible = "maxim,max5821";
+		reg = <0x38>;
+		vref-supply = <&reg_max5821>;
+	};
 };
 
 &i2c2 {
-- 
1.7.4.4
