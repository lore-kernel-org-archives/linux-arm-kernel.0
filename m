From: yao.yuan@freescale.com (Yuan Yao)
Date: Fri, 11 Sep 2015 13:53:53 +0800
Subject: [PATCH 2/2] dma: dts: Add Freescale qDMA engine driver support
In-Reply-To: <1441950833-27684-1-git-send-email-yao.yuan@freescale.com>
References: <1441950833-27684-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1441950833-27684-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Freescale Queue Direct Memory Access(qDMA) controller support.
This module can be found on LS-1 and LS-2 SoCs.

This add the legacy mode support for qDMA.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 973a496..fa82dae 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -388,6 +388,16 @@
 				 <&platform_clk 1>;
 		};
 
+		qdma: qdma at 8389000 {
+			      compatible = "fsl,ls-qdma";
+			      reg = <0x0 0x8389000 0x0 0x20000>;
+			      interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+					 <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			      interrupt-names = "qdma-tx", "qdma-err";
+			      channels = <1>;
+			      big-endian;
+		};
+
 		mdio0: mdio at 2d24000 {
 			compatible = "gianfar";
 			device_type = "mdio";
-- 
2.1.0.27.g96db324
