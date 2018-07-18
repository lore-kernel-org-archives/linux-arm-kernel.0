From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 18 Jul 2018 09:12:49 +0200
Subject: [PATCH v4 2/4] dt-bindings: arm: fsl: rework mu doc
In-Reply-To: <20180718071251.8857-1-o.rempel@pengutronix.de>
References: <20180718071251.8857-1-o.rempel@pengutronix.de>
Message-ID: <20180718071251.8857-3-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Remove software specific description. MU has many use cases
limited only by imagination. So remove this confusing part.
- Add all currently known SoCs with MU
- Make sure this documentation covers not only Firmware specific use
case. Parameters for generic configurations should be described as well.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/mailbox/fsl,mu.txt    | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 90e4905dfc69..9d5e6ee61e22 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -1,28 +1,26 @@
 NXP i.MX Messaging Unit (MU)
 --------------------------------------------------------------------
 
-The Messaging Unit module enables two processors within the SoC to
-communicate and coordinate by passing messages (e.g. data, status
-and control) through the MU interface. The MU also provides the ability
-for one processor to signal the other processor using interrupts.
-
-Because the MU manages the messaging between processors, the MU uses
-different clocks (from each side of the different peripheral buses).
-Therefore, the MU must synchronize the accesses from one side to the
-other. The MU accomplishes synchronization using two sets of matching
-registers (Processor A-facing, Processor B-facing).
-
-Messaging Unit Device Node:
-=============================
-
 Required properties:
 -------------------
-- compatible :	should be "fsl,<chip>-mu", the supported chips include
-		imx8qxp, imx8qm.
+- compatible :	should be "fsl,<chip>-mu", the supported chips include:
+		fsl,imx6sx-mu	- i.MX 6SoloX
+		fsl,imx7d-mu	- i.MX 7Dual
+		fsl,imx7s-mu	- i.MX 7Solo
+		fsl,imx7ulp-mu	- i.MX 7ULP
+		fsl,imx8qm-mu	- i.MX 8QM
+		fsl,imx8qxp-mu	- i.MX 8QXP
 - reg :		Should contain the registers location and length
 - interrupts :	Interrupt number. The interrupt specifier format depends
 		on the interrupt controller parent.
-- #mbox-cells:  Must be 0. Number of cells in a mailbox
+- #mbox-cells:  Must be:
+		0 - for single channel mode. i.MX8* SCU protocol specific.
+		1 - for multichannel (generic) mode.
+
+Optional properties:
+-------------------
+- clocks :	phandle to the input clock.
+- fsl,mu-side-b : Should be set for side B MU.
 
 Examples:
 --------
-- 
2.18.0
