From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 18 Aug 2016 14:38:47 +0800
Subject: [PATCH v1 4/5] ARM: dts: ls1043a: add qDMA node
In-Reply-To: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1471502328-28305-5-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Add the QDMA node for ls1043a platform to
support QDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index e8e4c3e..e463074 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -467,6 +467,16 @@
 				 <&clockgen 4 0>;
 		};
 
+		qdma: qdma at 8390000 {
+			compatible = "fsl,ls1021a-qdma", "fsl,ls1043a-qdma";
+			reg = <0x0 0x838f000 0x0 0x11000 /* Controller regs */
+			       0x0 0x83a0000 0x0 0x40000>; /* Block regs */
+			interrupts = <0 153 0x4>,
+					<0 39 0x4>;
+			interrupt-names = "qdma-error", "qdma-queue";
+			big-endian;
+		};
+
 		usb0: usb3 at 2f00000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
-- 
2.1.0.27.g96db324
