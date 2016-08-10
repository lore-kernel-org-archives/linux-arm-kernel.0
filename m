From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 10 Aug 2016 13:00:28 -0300
Subject: [PATCH 2/2] ARM: dts: imx7s: Add SDMA node
In-Reply-To: <1470844828-12848-1-git-send-email-fabio.estevam@nxp.com>
References: <1470844828-12848-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1470844828-12848-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a SDMA entry in the dtsi file.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 29246302..29fe328 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -956,6 +956,17 @@
 				status = "disabled";
 			};
 
+			sdma: sdma at 30bd0000 {
+				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_SDMA_CORE_CLK>,
+					 <&clks IMX7D_AHB_CHANNEL_ROOT_CLK>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet at 30be0000 {
 				compatible = "fsl,imx7d-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
1.9.1
