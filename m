From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 10:52:17 -0300
Subject: [PATCH 1/3] ARM: dts: imx53: Add 'ARM platform' node
Message-ID: <1529329939-14117-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As per the i.MX53 Reference Manual add an entry for the
'ARM platform' region in the device tree.

This is needed for accessing the ARM_GPC register to set the
DBGEN bit, so that the debug clocks can be turned on.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 1a7a7bb..a70fbf4 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -672,6 +672,11 @@
 				status = "disabled";
 			};
 
+			arm_platform: arm-platform at 63fa0000 {
+				compatible = "fsl,imx53-arm-plat", "fsl,imx51-arm-plat";
+				reg = <0x63fa0000 0x28>;
+			};
+
 			owire: owire at 63fa4000 {
 				compatible = "fsl,imx53-owire", "fsl,imx21-owire";
 				reg = <0x63fa4000 0x4000>;
-- 
2.7.4
