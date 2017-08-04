From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Fri, 4 Aug 2017 14:44:05 +0800
Subject: [PATCHv2 2/3] dts: ls1088a: add gicv3 ITS DT node
In-Reply-To: <1501829046-3761-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501829046-3761-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1501829046-3761-3-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add ITS device tree node, which will be used by PCIe controller.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - None

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c144d06..5f35797 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -126,6 +126,15 @@
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
2.1.0.27.g96db324
