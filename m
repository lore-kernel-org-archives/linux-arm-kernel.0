From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 Jul 2014 02:55:26 -0300
Subject: [PATCH 2/5] ARM: dts: imx6sx: Fix SSI nodes
In-Reply-To: <1404194129-25543-1-git-send-email-festevam@gmail.com>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
Message-ID: <1404194129-25543-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The fsl_ssi driver only needs one clock to work, so only pass the required
SSI clock as done in the other mx6 dtsi files.

Also pass the  fsl,fifo-depth property.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 2929078..ef3cea2 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -301,11 +301,10 @@
 					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
-						 <&clks IMX6SX_CLK_SSI1>;
-					clock-names = "ipg", "baud";
+					clocks = <&clks IMX6SX_CLK_SSI1>;
 					dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
 					dma-names = "rx", "tx";
+					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
 
@@ -313,11 +312,10 @@
 					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SX_CLK_SSI2_IPG>,
-						 <&clks IMX6SX_CLK_SSI2>;
-					clock-names = "ipg", "baud";
+					clocks = <&clks IMX6SX_CLK_SSI2>;
 					dmas = <&sdma 41 1 0>, <&sdma 42 1 0>;
 					dma-names = "rx", "tx";
+					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
 
@@ -325,11 +323,10 @@
 					compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-					clocks = <&clks IMX6SX_CLK_SSI3_IPG>,
-						 <&clks IMX6SX_CLK_SSI3>;
-					clock-names = "ipg", "baud";
+					clocks = <&clks IMX6SX_CLK_SSI3>;
 					dmas = <&sdma 45 1 0>, <&sdma 46 1 0>;
 					dma-names = "rx", "tx";
+					fsl,fifo-depth = <15>;
 					status = "disabled";
 				};
 
-- 
1.8.3.2
