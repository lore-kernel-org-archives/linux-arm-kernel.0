From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Dec 2017 10:20:16 -0200
Subject: [PATCH v2 12/12] ARM: dts: imx6ul-14x14-evk: Move regulators out of
 simple-bus
In-Reply-To: <1512390016-703-1-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
Message-ID: <1512390016-703-12-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is not recommended to place regulator nodes inside simple-bus, so
move them out in order to fix the following build warnings with W=1:

arch/arm/boot/dts/imx6ul-14x14-evk.dtb: Warning (simple_bus_reg): Node /regulators/sd1_regulator missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index e5d3ef8..18fdb08 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -30,19 +30,14 @@
 		status = "okay";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		reg_sd1_vmmc: sd1_regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "VSD_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	sound {
-- 
2.7.4
