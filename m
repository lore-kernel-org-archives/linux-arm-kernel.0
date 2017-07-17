From: martin@kaiser.cx (Martin Kaiser)
Date: Mon, 17 Jul 2017 23:16:01 +0200
Subject: [PATCH v3 1/3] Documentation: devicetree: add Freescale RNGC binding
In-Reply-To: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1500326163-4556-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Add binding documentation for the Freescale RNGC found on
some i.MX2/3 SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Changes in v3:
  - add compatible string for imx35
  - remove imx5 from the commit message,
    I couldn't find an i.MX5 soc that has an RNGC

Changes in v2:
  none

 Documentation/devicetree/bindings/rng/mxc_rngc.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/mxc_rngc.txt

diff --git a/Documentation/devicetree/bindings/rng/mxc_rngc.txt b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
new file mode 100644
index 0000000..5a12ada
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/mxc_rngc.txt
@@ -0,0 +1,16 @@
+Freescale RNGC (Random Number Generator Version C)
+
+Required properties:
+- compatible : Should be "fsl,imx25-rng" or "fsl,imx35-rng"
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
2.1.4
