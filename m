From: Anson.Huang@nxp.com (Anson Huang)
Date: Sat, 17 Mar 2018 15:36:55 +0800
Subject: [PATCH] ARM: dts: imx7s: add anatop vdd1p2 regulator
Message-ID: <1521272215-22514-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i.MX7S/D anatop vdd1p2 regulator.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index cd6964f..1210028 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -565,6 +565,21 @@
 					anatop-max-voltage = <1200000>;
 					anatop-enable-bit = <0>;
 				};
+
+				reg_1p2: regulator-vdd1p2 at 30360220 {
+					reg = <0x30360220>;
+					compatible = "fsl,anatop-regulator";
+					regulator-name = "vdd1p2";
+					regulator-min-microvolt = <1100000>;
+					regulator-max-microvolt = <1300000>;
+					anatop-reg-offset = <0x220>;
+					anatop-vol-bit-shift = <8>;
+					anatop-vol-bit-width = <5>;
+					anatop-min-bit-val = <0x14>;
+					anatop-min-voltage = <1100000>;
+					anatop-max-voltage = <1300000>;
+					anatop-enable-bit = <0>;
+				};
 			};
 
 			snvs: snvs at 30370000 {
-- 
2.7.4
