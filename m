From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 13:08:44 -0300
Subject: [PATCH v3 3/6] ARM: dts: imx51: Add tigerp support
In-Reply-To: <1531238927-19579-1-git-send-email-fabio.estevam@nxp.com>
References: <1531238927-19579-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1531238927-19579-3-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the i.MX51 Reference Manual add an entry for the
'tigerp' region in the device tree.

This is needed for accessing the ARM_GPC register to set the
DBGEN bit, so that the debug clocks can be turned on.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- None

 arch/arm/boot/dts/imx51.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 113ddbc..da9d4ce 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -451,6 +451,11 @@
 				clocks = <&clks IMX5_CLK_IIM_GATE>;
 			};
 
+			tigerp: tigerp at 83fa0000 {
+				compatible = "fsl,imx51-tigerp";
+				reg = <0x83fa0000 0x28>;
+			};
+
 			owire: owire at 83fa4000 {
 				compatible = "fsl,imx51-owire", "fsl,imx21-owire";
 				reg = <0x83fa4000 0x4000>;
-- 
2.7.4
