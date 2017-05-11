From: andy.tang@nxp.com (Yuantian Tang)
Date: Thu, 11 May 2017 16:01:19 +0800
Subject: [PATCH v2] arm64: dts: ls1088a: update the sata node
Message-ID: <1494489680-9544-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Sata ecc should be disabled due to a erratum.
Provide the ecc register address for driver to use.
2. Enable dma coherence operation

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2:
	- move dma-coherent property above status

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 2946fd7..caecd14 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -265,9 +265,12 @@
 
 		sata: sata at 3200000 {
 			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
-			reg = <0x0 0x3200000 0x0 0x10000>;
+			reg = <0x0 0x3200000 0x0 0x10000>,
+				<0x0 0x20140520 0x0 0x4>;
+			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 3>;
+			dma-coherent;
 			status = "disabled";
 		};
 	};
-- 
2.1.0.27.g96db324
