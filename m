From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 13 Apr 2017 06:32:36 -0700
Subject: [PATCH 2/8] ARM: dts: imx6: Specify 'anatop-enable-bit' where
 appropriate
In-Reply-To: <20170413133242.5068-1-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
Message-ID: <20170413133242.5068-3-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ENABLE_LINREG bit is implemented by 3P0, 1P1 and 2P5 regulators on
i.MX6. This property is present in similar code in Fresscale BSP and
made its way upstream in imx6ul.dtsi, so this patch adds this property
to the rest of i.MX6 family for completness.

Cc: yurovsky at gmail.com
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e426faa..0576ef6 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -644,6 +644,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -658,6 +659,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -672,6 +674,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2875000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index cc9572e..3243af4 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -530,6 +530,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -544,6 +545,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -558,6 +560,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2850000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 3f1416b..f16b9df 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -587,6 +587,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -601,6 +602,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -615,6 +617,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2875000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
-- 
2.9.3
