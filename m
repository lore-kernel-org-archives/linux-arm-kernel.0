From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 27 Oct 2016 13:06:44 -0200
Subject: [PATCH v2] ARM: dts: imx53-qsb: Fix regulator constraints
Message-ID: <1477580804-1423-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit fa93fd4ecc9c ("regulator: core: Ensure we are at least in
bounds for our constraints") the imx53-qsb board populated with a Dialog
DA9053 PMIC fails to boot:

LDO3: Bringing 3300000uV into 1800000-1800000uV

The LDO3 voltage constraints passed in the device tree do not match
the valid range according to the datasheet, so fix this accordingly to
allow the board booting again.

While at it, fix the other voltage constraints as well.

Cc: <stable@vger.kernel.org> # 4.7.x
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Mention the commit that causes the issue

 arch/arm/boot/dts/imx53-qsb.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index dec4b07..3799396 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -64,8 +64,8 @@
 			};
 
 			ldo3_reg: ldo3 {
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1725000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 
@@ -76,8 +76,8 @@
 			};
 
 			ldo5_reg: ldo5 {
-				regulator-min-microvolt = <1725000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
 				regulator-always-on;
 			};
 
@@ -100,14 +100,14 @@
 			};
 
 			ldo9_reg: ldo9 {
-				regulator-min-microvolt = <1200000>;
+				regulator-min-microvolt = <1250000>;
 				regulator-max-microvolt = <3600000>;
 				regulator-always-on;
 			};
 
 			ldo10_reg: ldo10 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3650000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
 				regulator-always-on;
 			};
 		};
-- 
2.7.4
