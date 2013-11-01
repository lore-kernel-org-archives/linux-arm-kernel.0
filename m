From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 1 Nov 2013 15:04:49 +0800
Subject: [PATCHv2 2/8] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio
 Interface node for VF610.
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1383289495-24523-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the SAI's edma mux Tx and Rx support.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 18e3a4c..391f180 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -151,9 +151,11 @@
 			sai2: sai at 40031000 {
 				compatible = "fsl,vf610-sai";
 				reg = <0x40031000 0x1000>;
-				interrupts = <0 86 0x04>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
+				dma-names = "tx", "rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
 				status = "disabled";
 			};
 
-- 
1.8.4
