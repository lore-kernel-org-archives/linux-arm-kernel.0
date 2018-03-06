From: martin@kaiser.cx (Martin Kaiser)
Date: Tue,  6 Mar 2018 22:58:19 +0100
Subject: [PATCH] ARM: dts: i.MX25: define SSI FIFO depth
Message-ID: <1520373499-13623-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the i.MX25 reference manuals, each SSI has four FIFOs. All
of those FIFOs can store up to 15 entries.

The fsl_ssi driver's internal default for the FIFO depth in 8. Set our
non-default FIFO depth explicitly in the Device Tree.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 arch/arm/boot/dts/imx25.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 9725705..cf70df2 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -269,6 +269,7 @@
 				dmas = <&sdma 24 1 0>,
 				       <&sdma 25 1 0>;
 				dma-names = "rx", "tx";
+				fsl,fifo-depth = <15>;
 				status = "disabled";
 			};
 
@@ -329,6 +330,7 @@
 				dmas = <&sdma 28 1 0>,
 				       <&sdma 29 1 0>;
 				dma-names = "rx", "tx";
+				fsl,fifo-depth = <15>;
 				status = "disabled";
 			};
 
-- 
2.1.4
