From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 10:47:34 -0300
Subject: [PATCH v2 4/6] ARM: dts: imx53: Add tigerp support
In-Reply-To: <1531230456-27717-1-git-send-email-fabio.estevam@nxp.com>
References: <1531230456-27717-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1531230456-27717-4-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the i.MX53 Reference Manual add an entry for the
'tigerp' region in the device tree.

This is needed for accessing the ARM_GPC register to set the
DBGEN bit, so that the debug clocks can be turned on.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Use the term 'tigerp' to follow the MX51 naming scheme

 arch/arm/boot/dts/imx53.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 1a7a7bb..3fd553c 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -672,6 +672,11 @@
 				status = "disabled";
 			};
 
+			tigerp: tigerp at 63fa0000 {
+				compatible = "fsl,imx53-tigerp", "fsl,imx51-tigerp";
+				reg = <0x63fa0000 0x28>;
+			};
+
 			owire: owire at 63fa4000 {
 				compatible = "fsl,imx53-owire", "fsl,imx21-owire";
 				reg = <0x63fa4000 0x4000>;
-- 
2.7.4
