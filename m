From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 1 Nov 2013 15:04:51 +0800
Subject: [PATCHv2 4/8] Documentation: Add device tree bindings for Freescale
 SAI.
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1383289495-24523-5-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Document for Freescale SAI driver under
Documentation/devicetree/bindings/sound/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
new file mode 100644
index 0000000..267afbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -0,0 +1,32 @@
+Freescale Synchronous Audio Interface (SAI).
+
+The SAI is based on I2S module that used communicating with audio codecs,
+which provides a synchronous audio interface that supports fullduplex
+serial interfaces with frame synchronization such as I2S, AC97, TDM, and
+codec/DSP interfaces.
+
+
+Required properties:
+- compatible: Compatible list, contains "fsl,vf610-sai".
+- reg: Offset and length of the register set for the device.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names : Must include the "sai" entry.
+- dmas : Generic dma devicetree binding as described in
+  Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names : Two dmas have to be defined, "tx" and "rx".
+- pinctrl-names: Must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+  See ../pinctrl/pinctrl-bindings.txt for details of the property values.
+
+Example:
+sai2: sai at 40031000 {
+	      compatible = "fsl,vf610-sai";
+	      reg = <0x40031000 0x1000>;
+	      pinctrl-names = "default";
+	      pinctrl-0 = <&pinctrl_sai2_1>;
+	      clocks = <&clks VF610_CLK_SAI2>;
+	      clock-names = "sai";
+	      dma-names = "tx", "rx";
+	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
+};
-- 
1.8.4
