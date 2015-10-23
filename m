From: yao.yuan@freescale.com (Yuan Yao)
Date: Fri, 23 Oct 2015 09:59:13 +0800
Subject: [PATCH v2 3/3] dma: dts: Add Freescale qDMA engine driver support
In-Reply-To: <1445565553-1141-1-git-send-email-yao.yuan@freescale.com>
References: <1445565553-1141-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1445565553-1141-3-git-send-email-yao.yuan@freescale.com>
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
index 9430a99..9d7073b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -428,6 +428,16 @@
 				 <&platform_clk 1>;
 		};
 
+		qdma: qdma at 8389000 {
+			      compatible = "fsl,ls1021a-qdma";
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
