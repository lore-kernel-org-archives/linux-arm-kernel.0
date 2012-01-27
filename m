From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 27 Jan 2012 18:30:05 +0100
Subject: [RFC PATCH 2/2] arm/dts: OMAP4: Add dma-controller and dma-request
 for I2C
Message-ID: <4F22DF1D.5020904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DMA controller node.

Add the dma-request attributes for the OMAP4 I2C controllers.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2938ec8..2425108 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,6 +104,13 @@
 			      <0x48240100 0x0100>;
 		};
 
+		sdma: sdma at 0 {
+			compatible = "ti,omap4-sdma";
+			ti,hwmods = "dma_system";
+			dma-controller;
+			#dma-cells = <1>;
+		};
+
 		gpio1: gpio at 1 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
@@ -205,6 +212,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			dma-request = <&sdma 27>, <&sdma 28>;
+			dma-request-names = "tx", "rx";
 		};
 
 		i2c2: i2c at 2 {
@@ -212,6 +221,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			dma-request = <&sdma 29>, <&sdma 30>;
+			dma-request-names = "tx", "rx";
 		};
 
 		i2c3: i2c at 3 {
@@ -219,6 +230,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			dma-request = <&sdma 25>, <&sdma 26>;
+			dma-request-names = "tx", "rx";
 		};
 
 		i2c4: i2c at 4 {
@@ -226,6 +239,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			dma-request = <&sdma 124>, <&sdma 125>;
+			dma-request-names = "tx", "rx";
 		};
 
 		mcspi1: mcspi at 1 {
-- 
1.7.0.4
