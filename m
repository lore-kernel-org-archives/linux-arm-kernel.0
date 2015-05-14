From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:31 +0900
Subject: [PATCH 02/31] ARM: shmobile: r8a7791: Remove MSIOF address from
 device tree
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <cb6d08a2b61fc0025a0148d06b71b8a7d0920e98.1431565427.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi                     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index 4c388bb2f0a2..8f771441be60 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -60,7 +60,7 @@ Example:
 
 	msiof0: spi at e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4696062f6dde..3e9f824797e7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1288,7 +1288,7 @@
 
 	msiof0: spi at e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
@@ -1300,7 +1300,7 @@
 
 	msiof1: spi at e6e10000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
@@ -1312,7 +1312,7 @@
 
 	msiof2: spi at e6e00000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
-- 
2.1.4
