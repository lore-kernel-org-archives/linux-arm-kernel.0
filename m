From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 Jan 2017 17:12:31 -0200
Subject: [PATCH] ARM: dts: imx53-qsb: Provide the TVE DAC regulators
Message-ID: <1483470751-8073-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

On imx53-qsb the TVE DAC regulator comes from:

- LDO7 on the board with the Dialog DA9052 PMIC
- VDAC on the board with the MC34708 PMIC

Pass them in the 'dac-supply' node.

While at it, remove the 'regulator-always-on/regulator-boot-on'
properties as the TVE driver will properly handle it.

Tested on a imx53-qsb board with a Dialog DA9052 PMIC.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-qsb.dts  | 5 ++++-
 arch/arm/boot/dts/imx53-qsrb.dts | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 3799396..f4c158c 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -90,7 +90,6 @@
 			ldo7_reg: ldo7 {
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
-				regulator-always-on;
 			};
 
 			ldo8_reg: ldo8 {
@@ -113,3 +112,7 @@
 		};
 	};
 };
+
+&tve {
+	dac-supply = <&ldo7_reg>;
+};
diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
index 96d7eed..479ca4c 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -130,8 +130,6 @@
 				regulator-name = "VDAC";
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2775000>;
-				regulator-boot-on;
-				regulator-always-on;
 			};
 
 			vgen1_reg: vgen1 {
@@ -152,3 +150,7 @@
 		};
 	};
 };
+
+&tve {
+	dac-supply = <&vdac_reg>;
+};
-- 
2.7.4
