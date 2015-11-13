From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Nov 2015 11:23:51 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7794: Use SoC specific binding for
 rcar-dmac nodes
In-Reply-To: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
References: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1447381431-2255-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new SoC specific binding for rcar-dmac and the generic
binding as a fall-back in the r8a7794 device tree.

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
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 018ff56470b6..33af10f2230f 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -221,7 +221,7 @@
 	};
 
 	dmac0: dma-controller at e6700000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
 		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
 			      0 200 IRQ_TYPE_LEVEL_HIGH
@@ -252,7 +252,7 @@
 	};
 
 	dmac1: dma-controller@e6720000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
 		reg = <0 0xe6720000 0 0x20000>;
 		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
 			      0 216 IRQ_TYPE_LEVEL_HIGH
-- 
2.1.4
