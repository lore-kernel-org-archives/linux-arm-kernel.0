From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Tue, 29 May 2018 19:04:36 +0200
Subject: [PATCH v3 5/5] ARM: dts: imx6qdl: add missing compatible and clock
 properties for EPIT
In-Reply-To: <20180529170436.22711-1-peron.clem@gmail.com>
References: <20180529170436.22711-1-peron.clem@gmail.com>
Message-ID: <20180529170436.22711-6-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Didier <colin.didier@devialet.com>

Add missing compatible and clock properties for EPIT node.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62bf290..75bbaca34cbc 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -844,13 +844,23 @@
 			};
 
 			epit1: epit at 20d0000 { /* EPIT1 */
+				compatible = "fsl,imx6q-epit";
 				reg = <0x020d0000 0x4000>;
 				interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT1>,
+					<&clks IMX6QDL_CLK_IPG_PER>;
+				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			epit2: epit at 20d4000 { /* EPIT2 */
+				compatible = "fsl,imx6q-epit";
 				reg = <0x020d4000 0x4000>;
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6QDL_CLK_EPIT2>,
+					<&clks IMX6QDL_CLK_IPG_PER>;
+				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			src: src at 20d8000 {
-- 
2.17.0
