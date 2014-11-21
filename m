From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:44 +0900
Subject: [PATCH 18/29] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific IIC
 compatible properties
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <7e9ad4d09d31ac696aa9baf4ff5c06cc015f7528.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The IIC nodes used the generic compatible properties only.
This may cause the driver to fail when using Standard Speed on IIC
masters where the operational clock is driven by the 130 MHz HP clock.

Add the SoC-specific compatible property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index b5ead84..01373ee 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -106,7 +106,7 @@
 	i2c5: i2c at e60b0000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -205,7 +205,7 @@
 	i2c0: i2c at e6500000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x428>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -214,7 +214,7 @@
 	i2c1: i2c at e6510000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x428>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -223,7 +223,7 @@
 	i2c2: i2c at e6520000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6520000 0 0x428>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -232,7 +232,7 @@
 	i2c3: i2c at e6530000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6530000 0 0x428>;
 		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -241,7 +241,7 @@
 	i2c4: i2c at e6540000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6540000 0 0x428>;
 		interrupts = <0 178 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -250,7 +250,7 @@
 	i2c6: i2c at e6550000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6550000 0 0x428>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -259,7 +259,7 @@
 	i2c7: i2c at e6560000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6560000 0 0x428>;
 		interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -268,7 +268,7 @@
 	i2c8: i2c at e6570000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-r8a73a4", "renesas,rmobile-iic";
 		reg = <0 0xe6570000 0 0x428>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
-- 
2.1.1
