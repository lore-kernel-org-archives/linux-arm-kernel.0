From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 30 Sep 2015 19:50:55 +0200
Subject: [PATCH v2 1/4] dt-bindings: add sunxi SPDIF transceiver bindings
In-Reply-To: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
Message-ID: <1443635458-8873-2-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add devicetree bindings for the SPDIF transceiver found on
found on Allwinners A10, A20 and A31 SoCs.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 .../devicetree/bindings/sound/sunxi,spdif.txt      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/sunxi,spdif.txt b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
new file mode 100644
index 0000000..1868722
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sunxi,spdif.txt
@@ -0,0 +1,49 @@
+Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
+
+The Allwinner S/PDIF audio block is a transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+
+Required properties:
+
+  - compatible		: should be one of the following:
+    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
+    - "allwinner,sun7i-a20-spdif": for the Allwinner A20 SoC
+    - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
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
+	"audio"		  clock from the audio pll.
+	"spdif"		  clock for spdif controller.
+
+Optional:
+
+  - spdif-in		: Enable block for capturing an SPDIF signal.
+
+  - spdif-out		: Enable block for transmitting an SPDIF signal.
+
+Example:
+
+spdif: spdif at 01c21000 {
+	compatible = "allwinner,sun4i-a10-spdif";
+	reg = <0x01c21000 0x40>;
+	interrupts = <13>;
+	clocks = <&apb0_gates 1>, <&pll2 0>, <&spdif_clk>;
+	clock-names = "apb", "audio", "spdif";
+	dmas = <&dma 0 2>, <&dma 0 2>;
+	dma-names = "rx", "tx";
+	spdif-in = "disabled";
+	spdif-out = "okay";
+	status = "okay";
+};
-- 
1.9.1
