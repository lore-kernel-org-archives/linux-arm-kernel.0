From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Mon, 18 Sep 2017 17:32:22 +0800
Subject: [PATCHv3 2/3] arm64: dts: ls1088a: add gicv3 ITS DT node
In-Reply-To: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
References: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20170918093223.33364-3-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add ITS device tree node, which will be used by PCIe controller.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - added 'arm64: ' prefix to the subject

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 33797b373674..97fcd8cbd118 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -147,6 +147,15 @@
 		      <0x0 0x0c0d0000 0 0x1000>, /* GICH */
 		      <0x0 0x0c0e0000 0 0x20000>; /* GICV */
 		interrupts = <1 9 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		its: gic-its at 6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x6020000 0 0x20000>;
+		};
 	};
 
 	timer {
-- 
2.14.1
