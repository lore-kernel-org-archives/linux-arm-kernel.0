From: codekipper@gmail.com (codekipper at gmail.com)
Date: Thu,  4 Feb 2016 12:09:21 +0100
Subject: [PATCH v4 1/2] dt-bindings: sunxi :add sun4i SPDIF transceiver
In-Reply-To: <1454584162-32449-1-git-send-email-codekipper@gmail.com>
References: <1454584162-32449-1-git-send-email-codekipper@gmail.com>
Message-ID: <1454584162-32449-2-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add devicetree bindings for the SPDIF transceiver found on
found on Allwinners A10 and A20 SoCs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../bindings/sound/sunxi,sun4i-spdif.txt           | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
new file mode 100644
index 0000000..13503aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
@@ -0,0 +1,39 @@
+Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
+
+The Allwinner S/PDIF audio block is a transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+For now only playback is supported.
+
+Required properties:
+
+  - compatible		: should be one of the following:
+    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
+
+  - reg			: Offset and length of the register set for the device.
+
+  - interrupts		: Contains the spdif interrupt.
+
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
+
+  - dma-names		: Two dmas have to be defined, "tx" and "rx".
+
+  - clocks		: Contains an entry for each entry in clock-names.
+
+  - clock-names		: Includes the following entries:
+	"apb"		  clock for the spdif bus.
+	"spdif"		  clock for spdif controller.
+
+Example:
+
+spdif: spdif at 01c21000 {
+	compatible = "allwinner,sun4i-a10-spdif";
+	reg = <0x01c21000 0x40>;
+	interrupts = <13>;
+	clocks = <&apb0_gates 1>, <&spdif_clk>;
+	clock-names = "apb", "spdif";
+	dmas = <&dma 0 2>, <&dma 0 2>;
+	dma-names = "rx", "tx";
+	status = "okay";
+};
-- 
2.7.0
