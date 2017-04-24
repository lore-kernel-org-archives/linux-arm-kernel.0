From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 25 Apr 2017 00:00:55 +0800
Subject: [PATCH v4 02/10] irqchip/sunxi-nmi: add A64 R_INTC to the binding doc
In-Reply-To: <20170424160103.9447-1-icenowy@aosc.io>
References: <20170424160103.9447-1-icenowy@aosc.io>
Message-ID: <20170424160103.9447-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 NMI driver seems to be using wrong base address.

As we're going to convert to use a correct NMI base address (and
correctly name it to R_INTC as the datasheet suggests), add a new
compatible string for the "correct" R_INTC, which we will use for A64
SoC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v4, which is part of NMI refactor.

 .../bindings/interrupt-controller/allwinner,sunxi-nmi.txt          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
index 81cd3692405e..fea0c6a6211f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-nmi.txt
@@ -3,8 +3,11 @@ Allwinner Sunxi NMI Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun7i-a20-sc-nmi" or
-  "allwinner,sun6i-a31-sc-nmi" or "allwinner,sun9i-a80-nmi"
+- compatible : should be one of:
+	"allwinner,sun6i-a31-sc-nmi"
+	"allwinner,sun7i-a20-sc-nmi"
+	"allwinner,sun9i-a80-nmi"
+	"allwinner,sun50i-a64-r-intc"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.12.2
