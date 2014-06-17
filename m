From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Jun 2014 11:06:30 +0200
Subject: [PATCH 2/7] ARM: dts: imx50, add ssi dma properties
In-Reply-To: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1402995995-15098-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace old ssi dma properties by the generic dma properties.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx50.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 6a201cf54366..c0e0f60ab6b2 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -151,8 +151,10 @@
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks IMX5_CLK_SSI2_IPG_GATE>;
+					dmas = <&sdma 24 1 0>,
+					       <&sdma 25 1 0>;
+					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
-					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
 					status = "disabled";
 				};
 
@@ -457,8 +459,10 @@
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks IMX5_CLK_SSI1_IPG_GATE>;
+				dmas = <&sdma 28 0 0>,
+				       <&sdma 29 0 0>;
+				dma-names = "rx", "tx";
 				fsl,fifo-depth = <15>;
-				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
 				status = "disabled";
 			};
 
-- 
2.0.0
