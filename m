From: jiaheng.fan@nxp.com (jiaheng.fan)
Date: Tue, 1 Aug 2017 10:14:10 +0800
Subject: [PATCH v1 5/6] arm: dts: ls1021: add qdma node to dtsi
In-Reply-To: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
References: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <1501553651-7203-6-git-send-email-jiaheng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: jiaheng.fan <jiaheng.fan@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 7bb9df2..b3bb74e 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -549,6 +549,21 @@
 				 <&clockgen 4 1>;
 		};
 
+		qdma: qdma at 8390000 {
+			compatible = "fsl,ls1021a-qdma";
+			reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
+			      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
+			      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "qdma-error", "qdma-queue";
+			channels = <8>;
+			queues = <2>;
+			status-sizes = <64>;
+			queue-sizes = <64 64>;
+			big-endian;
+		};
+
 		dcu: dcu at 2ce0000 {
 			compatible = "fsl,ls1021a-dcu";
 			reg = <0x0 0x2ce0000 0x0 0x10000>;
-- 
2.7.4
