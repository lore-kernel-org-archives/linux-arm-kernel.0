From: paulliu@debian.org (Ying-Chun Liu (PaulLiu))
Date: Wed,  9 May 2012 02:06:27 +0800
Subject: [PATCH] arm: imx53-qsb: Add Dialog DA9053 PMIC support
Message-ID: <1336500387-25546-1-git-send-email-paulliu@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>

Add Dialog DA9053 regulators support for imx53-qsb (Loco board)

Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Amit Kucheria <amit.kucheria@canonical.com>
Cc: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx53-qsb.dts |   74 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index b08b587..393e90d 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -73,8 +73,80 @@
 				};
 
 				pmic: dialog at 48 {
-					compatible = "dialog,da9053", "dialog,da9052";
+					compatible = "dlg,da9053-aa", "dlg,da9052";
 					reg = <0x48>;
+
+					regulators {
+						buck0 {
+							regulator-min-microvolt = <500000>;
+							regulator-max-microvolt = <2075000>;
+						};
+
+						buck1 {
+							regulator-min-microvolt = <500000>;
+							regulator-max-microvolt = <2075000>;
+						};
+
+						buck2 {
+							regulator-min-microvolt = <925000>;
+					                regulator-max-microvolt = <2500000>;
+						};
+
+						buck3 {
+							regulator-min-microvolt = <925000>;
+					                regulator-max-microvolt = <2500000>;
+						};
+
+						ldo4 {
+							regulator-min-microvolt = <600000>;
+							regulator-max-microvolt = <1800000>;
+						};
+
+						ldo5 {
+							regulator-min-microvolt = <600000>;
+					                regulator-max-microvolt = <1800000>;
+						};
+
+						ldo6 {
+							regulator-min-microvolt = <1725000>;
+					                regulator-max-microvolt = <3300000>;
+						};
+
+						ldo7 {
+							regulator-min-microvolt = <1725000>;
+					                regulator-max-microvolt = <3300000>;
+						};
+
+						ldo8 {
+							regulator-min-microvolt = <1200000>;
+					                regulator-max-microvolt = <3600000>;
+						};
+
+						ldo9 {
+							regulator-min-microvolt = <1200000>;
+					                regulator-max-microvolt = <3600000>;
+						};
+
+						ldo10 {
+							regulator-min-microvolt = <1200000>;
+					                regulator-max-microvolt = <3600000>;
+						};
+
+						ldo11 {
+							regulator-min-microvolt = <1200000>;
+					                regulator-max-microvolt = <3600000>;
+						};
+
+						ldo12 {
+							regulator-min-microvolt = <1250000>;
+					                regulator-max-microvolt = <3650000>;
+						};
+
+						ldo13 {
+							regulator-min-microvolt = <1200000>;
+					                regulator-max-microvolt = <3600000>;
+						};
+					};
 				};
 			};
 
-- 
1.7.10
