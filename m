From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 14 Mar 2016 11:13:58 +0900
Subject: [PATCH 1/2] ARM: dts: r8a7791: use fallback can compatibility string
In-Reply-To: <1457921639-15017-1-git-send-email-horms+renesas@verge.net.au>
References: <1457921639-15017-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1457921639-15017-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 9bfd1dc054b3..396a640927c8 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1013,7 +1013,7 @@
 	};
 
 	can0: can at e6e80000 {
-		compatible = "renesas,can-r8a7791";
+		compatible = "renesas,can-r8a7791", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e80000 0 0x1000>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
@@ -1024,7 +1024,7 @@
 	};
 
 	can1: can at e6e88000 {
-		compatible = "renesas,can-r8a7791";
+		compatible = "renesas,can-r8a7791", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e88000 0 0x1000>;
 		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
-- 
2.1.4
