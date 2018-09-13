From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:28 +0200
Subject: [PATCH 05/13] ARM: dts: rcar-gen2: Convert to new DU DT bindings
In-Reply-To: <cover.1536824376.git.horms+renesas@verge.net.au>
References: <cover.1536824376.git.horms+renesas@verge.net.au>
Message-ID: <b8ca3668a328b08eea1ed74dc11f72968b2e8032.1536824376.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The DU DT bindings have been updated to drop the reg-names property.
Update the r8a7792 and r8a7794 device trees accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 1 -
 arch/arm/boot/dts/r8a7794.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 63a978ec81cc..52d16a260db0 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -829,7 +829,6 @@
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7792";
 			reg = <0 0xfeb00000 0 0x40000>;
-			reg-names = "du";
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>,
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index ea2ca4bdaf1c..886135a273cb 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1349,7 +1349,6 @@
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7794";
 			reg = <0 0xfeb00000 0 0x40000>;
-			reg-names = "du";
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>;
-- 
2.11.0
