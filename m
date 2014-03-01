From: carlo@caione.org (Carlo Caione)
Date: Sat,  1 Mar 2014 17:45:52 +0100
Subject: [PATCH 7/7] ARM: dts: Cubieboard2: Add support for AXP209 regulators
In-Reply-To: <1393692352-10839-1-git-send-email-carlo@caione.org>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
Message-ID: <1393692352-10839-8-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables basic support for regulators found in AXP209 on
Cubieboard2.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 234b14b..2a0185a 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -66,6 +66,50 @@
 				compatible = "x-powers,axp209";
 				interrupt-controller;
 				#interrupt-cells = <1>;
+
+				regulators {
+					dcdc-freq = "8";
+
+					axp_dcdc2: dcdc2 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <2275000>;
+						dcdc-workmode = <0>;
+						regulator-always-on;
+					};
+
+					axp_dcdc3: dcdc3 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <3500000>;
+						dcdc-workmode = <0>;
+						regulator-always-on;
+					};
+
+					axp_ldo1: ldo1 {
+						regulator-min-microvolt = <1300000>;
+						regulator-max-microvolt = <1300000>;
+					};
+
+					axp_ldo2: ldo2 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3300000>;
+						regulator-always-on;
+					};
+
+					axp_ldo3: ldo3 {
+						regulator-min-microvolt = <700000>;
+						regulator-max-microvolt = <3500000>;
+					};
+
+					axp_ldo4: ldo4 {
+						regulator-min-microvolt = <1250000>;
+						regulator-max-microvolt = <3300000>;
+					};
+
+					axp_ldo5: ldo5 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <3300000>;
+					};
+				};
 			};
 		};
 
-- 
1.8.3.2
