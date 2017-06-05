From: andy.tang@nxp.com (Yuantian Tang)
Date: Mon, 5 Jun 2017 15:45:52 +0800
Subject: [PATCH] arm64: dts: ls1088a: update sata node
Message-ID: <1496648752-27627-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Remove ls1043a compatible string from node
2. Fix the sata ecc register address error

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index df16284..c144d06 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -360,9 +360,9 @@
 		};
 
 		sata: sata at 3200000 {
-			compatible = "fsl,ls1088a-ahci", "fsl,ls1043a-ahci";
+			compatible = "fsl,ls1088a-ahci";
 			reg = <0x0 0x3200000 0x0 0x10000>,
-				<0x0 0x20140520 0x0 0x4>;
+				<0x7 0x100520 0x0 0x4>;
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 3>;
-- 
2.1.0.27.g96db324
