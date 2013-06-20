From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 20 Jun 2013 22:08:13 +0900
Subject: [PATCH 2/3] ARM: shmobile: sh73a0: remove "0x" prefix from DT node
 names
In-Reply-To: <1371733694-27368-1-git-send-email-horms+renesas@verge.net.au>
References: <1371733694-27368-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371733694-27368-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The convention for Device Tree node names is <device>@<hex-address>, where
the part after '@' shouldn't contain the "0x" prefix. Fix the sh73a0.dtsi
DT names.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ec40bf7..b977502 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -119,7 +119,7 @@
 			      0 32 0x4>;
 	};
 
-	i2c0: i2c at 0xe6820000 {
+	i2c0: i2c at e6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -131,7 +131,7 @@
 			      0 170 0x4>;
 	};
 
-	i2c1: i2c at 0xe6822000 {
+	i2c1: i2c at e6822000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -143,7 +143,7 @@
 			      0 54 0x4>;
 	};
 
-	i2c2: i2c at 0xe6824000 {
+	i2c2: i2c at e6824000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -155,7 +155,7 @@
 			      0 174 0x4>;
 	};
 
-	i2c3: i2c at 0xe6826000 {
+	i2c3: i2c at e6826000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -167,7 +167,7 @@
 			      0 186 0x4>;
 	};
 
-	i2c4: i2c at 0xe6828000 {
+	i2c4: i2c at e6828000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -179,7 +179,7 @@
 			      0 190 0x4>;
 	};
 
-	mmcif: mmcif at 0x10010000 {
+	mmcif: mmcif at e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
@@ -189,7 +189,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi at 0xee100000 {
+	sdhi0: sdhi at ee100000 {
 		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
@@ -201,7 +201,7 @@
 	};
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
-	sdhi1: sdhi at 0xee120000 {
+	sdhi1: sdhi at ee120000 {
 		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
@@ -212,7 +212,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi at 0xee140000 {
+	sdhi2: sdhi at ee140000 {
 		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.8.2.1
