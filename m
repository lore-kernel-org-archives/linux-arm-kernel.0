From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:55 +0900
Subject: [PATCH 25/25] ARM: shmobile: r8a779x: use SoC-specific usb-dmac
 compatibility strings
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <d01c8bec91414f2110370dfcb9dd33fc0e573cee.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently SoC-specific compatibility strings in r8a779[01] device trees.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee587cd823f5..7dfd393bfc7e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -386,7 +386,7 @@
 	};
 
 	usb_dmac0: dma-controller at e65a0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65a0000 0 0x100>;
 		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -398,7 +398,7 @@
 	};
 
 	usb_dmac1: dma-controller at e65b0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65b0000 0 0x100>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3f15aa7dc4d6..2a369ddcb6fd 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -375,7 +375,7 @@
 	};
 
 	usb_dmac0: dma-controller at e65a0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65a0000 0 0x100>;
 		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -387,7 +387,7 @@
 	};
 
 	usb_dmac1: dma-controller at e65b0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65b0000 0 0x100>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4
