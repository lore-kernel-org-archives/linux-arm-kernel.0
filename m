From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Dec 2017 10:20:15 -0200
Subject: [PATCH v2 11/12] ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded
 unit address
In-Reply-To: <1512390016-703-1-git-send-email-festevam@gmail.com>
References: <1512390016-703-1-git-send-email-festevam@gmail.com>
Message-ID: <1512390016-703-11-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove the unneeded unit address for the i2cmux nodes in order to fix
the following build warnings with W=1:

arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 2 has a unit name, but no reg property
arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 3 has a unit name, but no reg property

While at it, rename the i2cmux nodes and subnodes to make it clearer to which
i2c controller the mux belongs to.

Cc: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Rename the i2cmux nodes and subnodes for making it clear (Gary).

 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 3a77f0f..fd05f7c 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -172,7 +172,7 @@
 		};
 	};
 
-	i2cmux at 2 {
+	i2c2mux {
 		compatible = "i2c-mux-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c2mux>;
@@ -183,20 +183,20 @@
 		i2c-parent = <&i2c2>;
 		idle-state = <0>;
 
-		i2c2 at 1 {
+		i2c2mux at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
 
-		i2c2 at 2 {
+		i2c2mux at 2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
 	};
 
-	i2cmux at 3 {
+	i2c3mux {
 		compatible = "i2c-mux-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c3mux>;
@@ -206,7 +206,7 @@
 		i2c-parent = <&i2c3>;
 		idle-state = <0>;
 
-		i2c3 at 1 {
+		i2c3mux at 1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
