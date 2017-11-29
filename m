From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:46:16 -0200
Subject: [PATCH 08/11] ARM: dts: imx7s: Add unit address and reg for the
 anatop nodes
In-Reply-To: <1511981179-12660-1-git-send-email-festevam@gmail.com>
References: <1511981179-12660-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981179-12660-8-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Add unit address and reg for the anatop nodes in order to fix the
following build warnings with W=1:

arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 30000000/anatop at 30360000/regulator-vdd1p0d missing or empty reg/ranges property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 81467ac..2ceb37d 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -522,8 +522,11 @@
 				reg = <0x30360000 0x10000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-				reg_1p0d: regulator-vdd1p0d {
+				reg_1p0d: regulator-vdd1p0d at 30360210 {
+					reg = <0x30360210>;
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p0d";
 					regulator-min-microvolt = <800000>;
-- 
2.7.4
