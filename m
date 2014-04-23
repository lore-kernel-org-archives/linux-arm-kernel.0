From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:37 +0900
Subject: [PATCH 09/33] ARM: shmobile: r8a7779 dtsi: Improve and correct HSPI
 nodes
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <7709c33b391e217d73b38853a7914a3a3e285cbc.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

  - Add "renesas,hspi-r8a7779" compatible value,
  - Correct reference to parent interrupt controller
    (use "interrupt-parent" instead of "interrupt-controller"),
  - Add missing "#address-cells" and "#size-cells" properties, which are
    needed when populating the SPI buses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d0561d4..8b1a336 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -256,26 +256,32 @@
 	};
 
 	hspi0: spi at fffc7000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi1: spi at fffc8000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi2: spi at fffc6000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 };
-- 
1.8.5.2
