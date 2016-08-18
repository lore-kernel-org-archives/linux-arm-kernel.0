From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 18 Aug 2016 14:38:48 +0800
Subject: [PATCH v1 5/5] ARM: dts: ls1021a: add qDMA node
In-Reply-To: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1471502328-28305-6-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Add the QDMA node for ls1021a platform to
support QDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..a1ca071 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -493,6 +493,16 @@
 				 <&platform_clk 1>;
 		};
 
+		qdma: qdma at 8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8398000 0x0 0x2000 /* Controller regs */
+			       0x0 0x839a000 0x0 0x2000>; /* Block regs */
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-error", "qdma-queue";
+			big-endian;
+		};
+
 		dcu: dcu at 2ce0000 {
 			compatible = "fsl,ls1021a-dcu";
 			reg = <0x0 0x2ce0000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
