From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:45 +0900
Subject: [PATCH 19/29] ARM: shmobile: sh73a0 dtsi: Add SoC-specific IIC
 compatible properties
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <dd4dc874d16b87944e6803f41dc9477c3c6f09d6.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The IIC nodes used the generic compatible properties only.
This causes the driver to fail when using Standard Speed, as the
operational clock is driven by the 104 MHz HP clock:

    i2c-sh_mobile e6820000.i2c: timing values out of range: L/H=0x208/0x1bf
    i2c-sh_mobile: probe of e6820000.i2c failed with error -22

Add the SoC-specific compatible property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 030a592..d8def5a 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -138,7 +138,7 @@
 	i2c0: i2c at e6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6820000 0x425>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH
 			      0 168 IRQ_TYPE_LEVEL_HIGH
@@ -150,7 +150,7 @@
 	i2c1: i2c@e6822000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6822000 0x425>;
 		interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH
 			      0 52 IRQ_TYPE_LEVEL_HIGH
@@ -162,7 +162,7 @@
 	i2c2: i2c@e6824000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6824000 0x425>;
 		interrupts = <0 171 IRQ_TYPE_LEVEL_HIGH
 			      0 172 IRQ_TYPE_LEVEL_HIGH
@@ -174,7 +174,7 @@
 	i2c3: i2c@e6826000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6826000 0x425>;
 		interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH
 			      0 184 IRQ_TYPE_LEVEL_HIGH
@@ -186,7 +186,7 @@
 	i2c4: i2c@e6828000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6828000 0x425>;
 		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH
 			      0 188 IRQ_TYPE_LEVEL_HIGH
-- 
2.1.1
