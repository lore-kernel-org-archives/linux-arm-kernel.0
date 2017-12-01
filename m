From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  1 Dec 2017 17:24:44 -0200
Subject: [PATCH 11/12] ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded unit
 address
In-Reply-To: <1512156285-18451-1-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
Message-ID: <1512156285-18451-11-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove the unneeded unit address for the i2cmux nodes in order to fix
the following build warnings with W=1:

arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 2 has a unit name, but no reg property
arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (unit_address_vs_reg): Node /i2cmux at 3 has a unit name, but no reg property

Cc: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 3a77f0f..3cdffed 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -172,7 +172,7 @@
 		};
 	};
 
-	i2cmux at 2 {
+	i2cmux2 {
 		compatible = "i2c-mux-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c2mux>;
@@ -196,7 +196,7 @@
 		};
 	};
 
-	i2cmux at 3 {
+	i2cmux3 {
 		compatible = "i2c-mux-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c3mux>;
-- 
2.7.4
