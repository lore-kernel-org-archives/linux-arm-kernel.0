From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 15 Jun 2018 11:51:05 +0200
Subject: [PATCH v2 2/4] dt-bindings: mailbox: provide imx-mailbox documentation
In-Reply-To: <20180615095107.24610-1-o.rempel@pengutronix.de>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
Message-ID: <20180615095107.24610-3-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/mailbox/imx-mailbox.txt          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/imx-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
new file mode 100644
index 000000000000..1577b86f1206
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
@@ -0,0 +1,35 @@
+i.MX Messaging Unit
+===================
+
+The i.MX Messaging Unit (MU) contains two register sets: "A" and "B". In most
+cases they are accessible from all Processor Units. On one hand, at least for
+mailbox functionality, it makes no difference which application or processor is
+using which set of the MU. On other hand, the register sets for each of the MU
+parts are not identical.
+
+Required properties:
+- compatible :	Shell be one of:
+                    "fsl,imx7s-mu-a" and "fsl,imx7s-mu-b" for i.MX7S or i.MX7D
+- reg :		physical base address of the mailbox and length of
+		memory mapped region.
+- #mbox-cells:	Common mailbox binding property to identify the number
+		of cells required for the mailbox specifier. Should be 1.
+- interrupts :	The interrupt number
+- clocks     :  phandle to the input clock.
+
+Example:
+	mu0a: mailbox at 30aa0000 {
+		compatible = "fsl,imx7s-mu-a";
+		reg = <0x30aa0000 0x28>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX7D_MU_ROOT_CLK>;
+		#mbox-cells = <1>;
+	};
+
+	mu0b: mailbox at 30ab0000 {
+		compatible = "fsl,imx7s-mu-b";
+		reg = <0x30ab0000 0x28>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX7D_MU_ROOT_CLK>;
+		#mbox-cells = <1>;
+	};
-- 
2.17.1
