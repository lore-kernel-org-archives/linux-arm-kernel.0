From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Nov 2015 11:23:48 +0900
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Use SoC specific binding for
 rcar-dmac nodes
In-Reply-To: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
References: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1447381431-2255-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new SoC specific binding for rcar-dmac and the generic
binding as a fall-back in the r8a7790 device tree.

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
most drivers for Renesas hardware. The purpose of this patch is to
update the Renesas R-Car DMA Controller nodes to follow this convention.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0612502b4a6d..9f3036b80c0e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -266,7 +266,7 @@
 	};
 
 	dmac0: dma-controller at e6700000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
 		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
 			      0 200 IRQ_TYPE_LEVEL_HIGH
@@ -297,7 +297,7 @@
 	};
 
 	dmac1: dma-controller@e6720000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xe6720000 0 0x20000>;
 		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
 			      0 216 IRQ_TYPE_LEVEL_HIGH
@@ -328,7 +328,7 @@
 	};
 
 	audma0: dma-controller@ec700000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xec700000 0 0x10000>;
 		interrupts =	<0 346 IRQ_TYPE_LEVEL_HIGH
 				 0 320 IRQ_TYPE_LEVEL_HIGH
@@ -357,7 +357,7 @@
 	};
 
 	audma1: dma-controller@ec720000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xec720000 0 0x10000>;
 		interrupts =	<0 347 IRQ_TYPE_LEVEL_HIGH
 				 0 333 IRQ_TYPE_LEVEL_HIGH
-- 
2.1.4
