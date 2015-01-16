From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:13 +0900
Subject: [PATCH 01/17] ARM: shmobile: sh73a0 dtsi: Set control-parent for all
 irqpin nodes
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <ac481d2ebdfa50761827f604dc224c5a5de0ad69.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh73a0 INTC can't mask interrupts properly most likely due to a
hardware bug. Set the control-parent property to delegate masking to the
parent interrupt controller.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index cca22ec..1cd7b58 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -78,6 +78,7 @@
 			      0 6 IRQ_TYPE_LEVEL_HIGH
 			      0 7 IRQ_TYPE_LEVEL_HIGH
 			      0 8 IRQ_TYPE_LEVEL_HIGH>;
+		control-parent;
 	};
 
 	irqpin1: irqpin at e6900004 {
@@ -117,6 +118,7 @@
 			      0 22 IRQ_TYPE_LEVEL_HIGH
 			      0 23 IRQ_TYPE_LEVEL_HIGH
 			      0 24 IRQ_TYPE_LEVEL_HIGH>;
+		control-parent;
 	};
 
 	irqpin3: irqpin at e690000c {
@@ -136,6 +138,7 @@
 			      0 30 IRQ_TYPE_LEVEL_HIGH
 			      0 31 IRQ_TYPE_LEVEL_HIGH
 			      0 32 IRQ_TYPE_LEVEL_HIGH>;
+		control-parent;
 	};
 
 	i2c0: i2c at e6820000 {
-- 
2.1.4
