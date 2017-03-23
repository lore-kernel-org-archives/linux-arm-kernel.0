From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 23 Mar 2017 15:44:17 +0100
Subject: [PATCH 1/2] dt-bindings: imx-gpc: add i.MX6 QuadPlus compatible
In-Reply-To: <20170323144418.30977-1-l.stach@pengutronix.de>
References: <20170323144418.30977-1-l.stach@pengutronix.de>
Message-ID: <20170323144418.30977-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the GPC on i.MX6QP is mostly comptible to the i.MX6Q one,
the QuadPlus requires special workarounds for hardware erratum
ERR009619.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
index 416e12c6755a..181d2cc6f054 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
@@ -5,7 +5,10 @@ The i.MX6 General Power Control (GPC) block contains DVFS load tracking
 counters and Power Gating Control (PGC).
 
 Required properties:
-- compatible: Should be "fsl,imx6q-gpc" or "fsl,imx6sl-gpc"
+- compatible: Should be one of the following:
+  - fsl,imx6q-gpc
+  - fsl,imx6qp-gpc
+  - fsl,imx6sl-gpc
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain one interrupt specifier for the GPC interrupt
-- 
2.11.0
