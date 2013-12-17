From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Tue, 17 Dec 2013 11:24:39 +0800
Subject: [PATCHv3 2/7] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio
 Interface node for VF610.
In-Reply-To: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1387250684-23406-3-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SAI's edma mux Tx and Rx support.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e84d84c..2d6ddd0 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -166,6 +166,9 @@
 				interrupts = <0 86 0x04>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
+				dma-names = "tx", "rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
 				status = "disabled";
 			};
 
-- 
1.8.4
