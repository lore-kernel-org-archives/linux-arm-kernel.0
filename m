From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  3 Mar 2017 11:45:53 +0100
Subject: [PATCH 2/2] dt-bindings: nvmem: Add i.MX IIM binding doc
In-Reply-To: <20170303104553.18477-1-s.hauer@pengutronix.de>
References: <20170303104553.18477-1-s.hauer@pengutronix.de>
Message-ID: <20170303104553.18477-3-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IIM is part of the i.MX device trees for long already, add a binding
document for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/nvmem/imx-iim.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt

diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.txt b/Documentation/devicetree/bindings/nvmem/imx-iim.txt
new file mode 100644
index 000000000000..1978c5bcd96d
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/imx-iim.txt
@@ -0,0 +1,22 @@
+Freescale i.MX IC Identification Module (IIM) device tree bindings
+
+This binding represents the IC Identification Module (IIM) found on
+i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
+
+Required properties:
+- compatible: should be one of
+	"fsl,imx25-iim", "fsl,imx27-iim",
+	"fsl,imx31-iim", "fsl,imx35-iim",
+	"fsl,imx51-iim", "fsl,imx53-iim",
+- reg: Should contain the register base and length.
+- interrupts: Should contain the interrupt for the IIM
+- clocks: Should contain a phandle pointing to the gated peripheral clock.
+
+Example:
+
+	iim: iim at 63f98000 {
+		compatible = "fsl,imx53-iim", "fsl,imx27-iim";
+		reg = <0x63f98000 0x4000>;
+		interrupts = <69>;
+                clocks = <&clks IMX5_CLK_IIM_GATE>;
+	};
-- 
2.11.0
