From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri,  8 Apr 2016 16:30:59 +0200
Subject: [PATCH v4 1/3] Documentation: devicetree: add Freescale SCC bindings
Message-ID: <1460125861-22876-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the Freescale Security Controller (SCC)
found on i.MX25 SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:

  - add clocks to required properties
  - add Acked-by

 .../devicetree/bindings/crypto/fsl-imx-scc.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt b/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
new file mode 100644
index 000000000000..7aad448e8a36
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
@@ -0,0 +1,21 @@
+Freescale Security Controller (SCC)
+
+Required properties:
+- compatible : Should be "fsl,imx25-scc".
+- reg : Should contain register location and length.
+- interrupts : Should contain interrupt numbers for SCM IRQ and SMN IRQ.
+- interrupt-names : Should specify the names "scm" and "smn" for the
+		    SCM IRQ and SMN IRQ.
+- clocks: Should contain the clock driving the SCC core.
+- clock-names: Should be set to "ipg".
+
+Example:
+
+	scc: crypto at 53fac000 {
+		compatible = "fsl,imx25-scc";
+		reg = <0x53fac000 0x4000>;
+		clocks = <&clks 111>;
+		clock-names = "ipg";
+		interrupts = <49>, <50>;
+		interrupt-names = "scm", "smn";
+	};
-- 
2.7.0
