From: andy.tang@nxp.com (Yuantian Tang)
Date: Mon, 8 May 2017 11:13:29 +0800
Subject: [PATCH] arm64: dts: ls1088a: update the sata node
Message-ID: <1494213209-39673-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Sata ecc should be disabled due to a erratum.
Provide the ecc register address for driver to use.
2. Enable dma coherence operation

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 2946fd7..90edd76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -265,10 +265,13 @@
 
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>;
+			reg = <0x0 0x3200000 0x0 0x10000>,
+				<0x0 0x20140520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 3>;
 			status = "disabled";
+			dma-coherent;
 		};
 	};
 
-- 
2.1.0.27.g96db324
