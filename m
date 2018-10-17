From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 17 Oct 2018 12:37:54 +0000
Subject: [PATCH v4 3/4] ARM: dts: imx6ull: Add dcp node
In-Reply-To: <cover.1539779579.git.leonard.crestez@nxp.com>
References: <cover.1539779579.git.leonard.crestez@nxp.com>
Message-ID: <f503eea6c702aeff091f4c03d4059b67ec17b2b4.1539779579.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DCP block on 6ull has no major differences other than requiring
explicit clock enabling.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 796ed35d4ac9..f3668fe69eac 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -37,10 +37,20 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x02200000 0x100000>;
 			ranges;
 
+			dcp: crypto at 2280000 {
+				compatible = "fsl,imx6ull-dcp", "fsl,imx28-dcp";
+				reg = <0x02280000 0x4000>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6ULL_CLK_DCP_CLK>;
+				clock-names = "dcp";
+			};
+
 			iomuxc_snvs: iomuxc-snvs at 2290000 {
 				compatible = "fsl,imx6ull-iomuxc-snvs";
 				reg = <0x02290000 0x4000>;
 			};
 
-- 
2.17.1
