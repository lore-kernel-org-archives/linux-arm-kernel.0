From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 11 Mar 2016 15:06:38 +0100
Subject: [PATCH v2 1/3] Documentation: devicetree: add Freescale RNGC binding
Message-ID: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the Freescale RNGC found on
some i.MX2/3/5 SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/rng/mxc_rngc.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/mxc_rngc.txt

diff --git a/Documentation/devicetree/bindings/rng/mxc_rngc.txt b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
new file mode 100644
index 000000000000..e147a6dde40a
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
@@ -0,0 +1,16 @@
+Freescale RNGC (Random Number Generator Version C)
+
+Required properties:
+- compatible : Should be "fsl,imx25-rng"
+- reg : Offset and length of the register set of this block
+- interrupts : the interrupt number for the RNG block
+- clocks: should contain the RNG clk source
+
+Example:
+
+rng at 53fb0000 {
+	compatible = "fsl,imx25-rng";
+	reg = <0x53fb0000 0x4000>;
+	interrupts = <22>;
+	clocks = <&trng_clk>;
+};
-- 
2.7.0
