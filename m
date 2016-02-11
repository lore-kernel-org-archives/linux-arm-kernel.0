From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 11 Feb 2016 15:04:43 +0100
Subject: [PATCH 1/3] Documentation: devicetree: add Freescale SCC bindings
Message-ID: <1455199485-24458-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the Freescale Security Controller (SCC)
found on i.MX25 SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 .../devicetree/bindings/crypto/fsl-imx-scc.txt          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt b/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
new file mode 100644
index 000000000000..9a15ab8da94f
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
@@ -0,0 +1,17 @@
+Freescale Security Controller (SCC)
+
+Required properties:
+- compatible : Should be "fsl,imx25-scc".
+- reg : Should contain register location and length.
+- interrupts : Should contain interrupt numbers for SCM IRQ and SMN IRQ.
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
2.7.0.rc3
