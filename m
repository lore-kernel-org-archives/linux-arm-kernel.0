From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 29 Mar 2013 16:49:17 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SoC 64-bit DT support
Message-ID: <20130329074917.15695.92956.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

The r8a7790 SoC supports LPAE and has memory window up to
0x2ffffffff. Convert to 64-bit addresses by enlarging
#addr-cells and #size-cells to 2.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- 0008/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-03-29 16:35:32.000000000 +0900
@@ -8,11 +8,11 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
-
 / {
 	compatible = "renesas,r8a7790";
 	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	cpus {
 		#address-cells = <1>;
@@ -31,10 +31,10 @@
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-		reg = <0xf1001000 0x1000>,
-			<0xf1002000 0x1000>,
-			<0xf1004000 0x2000>,
-			<0xf1006000 0x2000>;
+		reg = <0 0xf1001000 0 0x1000>,
+			<0 0xf1002000 0 0x1000>,
+			<0 0xf1004000 0 0x2000>,
+			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
 
 		gic-cpuif at 4 {
@@ -56,7 +56,7 @@
 		compatible = "renesas,irqc";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		reg = <0xe61c0000 0x200>;
+		reg = <0 0xe61c0000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
