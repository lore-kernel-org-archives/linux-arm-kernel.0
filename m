From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:26 +0900
Subject: [PATCH 30/30] ARM: shmobile: r8a7790 SoC 64-bit DT support
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-31-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

The r8a7790 SoC supports LPAE and has memory window up to
0x2ffffffff. Convert to 64-bit addresses by enlarging
#addr-cells and #size-cells to 2.

Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a1e0e0c..7a17110 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
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
-- 
1.7.10.4
