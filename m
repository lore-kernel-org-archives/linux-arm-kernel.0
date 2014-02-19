From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Wed, 19 Feb 2014 15:42:28 +0800
Subject: [PATCH v2 1/4] ARM: dts: vf610: Add edma mux Tx and Rx support for
 SAI node.
In-Reply-To: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
References: <1392795751-13351-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1392795751-13351-2-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SAI's edma mux Tx and Rx support.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/vf610.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 91a7757..f08df47 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -169,6 +169,9 @@
 				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
+				dma-names = "tx", "rx";
+				dmas = <&edma0 0 21>,
+					<&edma0 0 20>;
 				status = "disabled";
 			};
 
-- 
1.8.4
