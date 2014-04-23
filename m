From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:50 +0900
Subject: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif,
 fsi2 compat strings
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

Add "renesas,*-r8a7740" to the compatible strings for consistency with other
devices.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 8280884..9f65986 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -126,7 +126,7 @@
 	i2c0: i2c at fff20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
 		reg = <0xfff20000 0x425>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 201 IRQ_TYPE_LEVEL_HIGH
@@ -139,7 +139,7 @@
 	i2c1: i2c@e6c20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
 		reg = <0xe6c20000 0x425>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH
@@ -174,7 +174,7 @@
 	};
 
 	mmcif0: mmc@e6bd0000 {
-		compatible = "renesas,sh-mmcif";
+		compatible = "renesas,mmcif-r8a7740", "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH
@@ -220,7 +220,7 @@
 
 	sh_fsi2: sound@fe1f0000 {
 		#sound-dai-cells = <1>;
-		compatible = "renesas,sh_fsi2";
+		compatible = "renesas,fsi2-r8a7740", "renesas,sh_fsi2";
 		reg = <0xfe1f0000 0x400>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 9 0x4>;
-- 
1.8.5.2
