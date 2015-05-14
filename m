From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 14 May 2015 10:06:30 +0900
Subject: [PATCH 01/31] ARM: shmobile: r8a7790: Remove MSIOF address from
 device tree
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
Message-ID: <c7d1f08a0c91ad9796d6d1fac8eb913e8a6d4288.1431565427.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4bb2f4c17321..f3b8430070b6 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1273,7 +1273,7 @@
 
 	msiof0: spi at e6e20000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
@@ -1285,7 +1285,7 @@
 
 	msiof1: spi at e6e10000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
@@ -1297,7 +1297,7 @@
 
 	msiof2: spi at e6e00000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
@@ -1309,7 +1309,7 @@
 
 	msiof3: spi at e6c90000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6c90000 0 0x0064>, <0 0xe7c90000 0 0x0064>;
+		reg = <0 0xe6c90000 0 0x0064>;
 		interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
-- 
2.1.4
