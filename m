From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:38 +0900
Subject: [PATCH 06/47] ARM: dts: r8a7790: use fallback can compatibility string
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <727779c6b0144dfb93dea3b09fa706760ac9e1ce.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b2d6a0f6105c..0077de70b6a4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -982,7 +982,7 @@
 	};
 
 	can0: can at e6e80000 {
-		compatible = "renesas,can-r8a7790";
+		compatible = "renesas,can-r8a7790", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e80000 0 0x1000>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
@@ -993,7 +993,7 @@
 	};
 
 	can1: can at e6e88000 {
-		compatible = "renesas,can-r8a7790";
+		compatible = "renesas,can-r8a7790", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e88000 0 0x1000>;
 		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
-- 
2.1.4
