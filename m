From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Sun, 15 Mar 2015 23:43:38 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Remove MSIOF address from device
 tree
Message-ID: <1426430618-3818-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on devel branch of Simon Horman's renesas tree.

 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4bb2f4c..f3b8430 100644
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
1.9.1
