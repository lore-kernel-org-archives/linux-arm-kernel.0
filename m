From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Sun, 22 Jul 2018 08:39:21 +0200
Subject: [PATCH v6 3/5] dt-bindings: mailbox: imx-mu: add generic MU channel
 support
In-Reply-To: <20180722063923.30222-1-o.rempel@pengutronix.de>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
Message-ID: <20180722063923.30222-4-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each MU has four pairs of rx/tx data register with four rx/tx interrupts
which can also be used as a separate channel.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 90e4905dfc69..113d6ab931ef 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -22,7 +22,14 @@ Required properties:
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
