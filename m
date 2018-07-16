From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 16 Jul 2018 13:42:07 +0200
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180716114209.25242-1-o.rempel@pengutronix.de>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
Message-ID: <20180716114209.25242-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Messaging Unit module enables two processors within
the SoC to communicate and coordinate by passing messages
(e.g. data, status and control) through the MU interface.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/mailbox/fsl,mu.txt    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
new file mode 100644
index 000000000000..5d48dd75b98d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -0,0 +1,32 @@
+NXP i.MX Messaging Unit (MU)
+--------------------------------------------------------------------
+
+Required properties:
+-------------------
+- compatible :	should be "fsl,<chip>-mu", the supported chips include:
+		imx6sx	- i.MX 6SoloX
+		imx7d	- i.MX 7Dual
+		imx7s	- i.MX 7Solo
+		imx7ulp	- i.MX 7ULP
+		imx8qm	- i.MX 8QM
+		imx8qxp	- i.MX 8QXP
+- reg :		Should contain the registers location and length
+- interrupts :	Interrupt number. The interrupt specifier format depends
+		on the interrupt controller parent.
+- #mbox-cells:  Must be:
+		0 - for single channel mode. i.MX8* SCU protocol specific.
+		1 - for multichannel (generic) mode.
+
+Optional properties:
+-------------------
+- clocks :	phandle to the input clock.
+- fsl,mu-side-a : Should be set for side A MU.
+
+Examples:
+--------
+lsio_mu0: mailbox at 5d1b0000 {
+	compatible = "fsl,imx8qxp-mu";
+	reg = <0x0 0x5d1b0000 0x0 0x10000>;
+	interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+	#mbox-cells = <0>;
+};
-- 
2.18.0
