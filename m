From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 10 Jan 2017 08:30:13 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: Specify 'anatop-enable-bit' where
 appropriate
Message-ID: <20170110163015.22444-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ENABLE_LINREG bit is implemented by 3P0, 1P1 and 2P5 regulators on
i.MX6. This property is present in similar code in Fresscale BSP and
made its way upstream in imx6ul.dtsi, so this patch adds this property
to the rest of i.MX6 family for completness.

Cc: yurovsky at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 89b834f..9702e18 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -635,6 +635,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -649,6 +650,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -663,6 +665,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2000000>;
 					anatop-max-voltage = <2750000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 19cbd87..a478a06f 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -522,6 +522,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -536,6 +537,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -550,6 +552,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2850000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 10f3330..3de3cca 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -578,6 +578,7 @@
 					anatop-min-bit-val = <4>;
 					anatop-min-voltage = <800000>;
 					anatop-max-voltage = <1375000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-3p0 {
@@ -592,6 +593,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2625000>;
 					anatop-max-voltage = <3400000>;
+					anatop-enable-bit = <0>;
 				};
 
 				regulator-2p5 {
@@ -606,6 +608,7 @@
 					anatop-min-bit-val = <0>;
 					anatop-min-voltage = <2100000>;
 					anatop-max-voltage = <2875000>;
+					anatop-enable-bit = <0>;
 				};
 
 				reg_arm: regulator-vddcore {
-- 
2.9.3
