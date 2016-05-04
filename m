From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 May 2016 22:12:00 -0300
Subject: [PATCH 1/2] ARM: dts: imx6ul: Specify the SAI index
Message-ID: <1462324321-11060-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Introduce the "sai-index" property to indicate the index of the SAI port.

This is useful for enabling the SAI_MCLK output as we need to write
to bits 19, 20 and 21 of register GPR1 for enabling SAI1, SAI2 and SAI3,
respectively.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 4356b65..b11d5a8 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -281,6 +281,7 @@
 					dmas = <&sdma 35 24 0>,
 					       <&sdma 36 24 0>;
 					dma-names = "rx", "tx";
+					sai-index = <1>;
 					status = "disabled";
 				};
 
@@ -296,6 +297,7 @@
 					dmas = <&sdma 37 24 0>,
 					       <&sdma 38 24 0>;
 					dma-names = "rx", "tx";
+					sai-index = <2>;
 					status = "disabled";
 				};
 
@@ -311,6 +313,7 @@
 					dmas = <&sdma 39 24 0>,
 					       <&sdma 40 24 0>;
 					dma-names = "rx", "tx";
+					sai-index = <3>;
 					status = "disabled";
 				};
 			};
-- 
1.9.1
