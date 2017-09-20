From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Sep 2017 15:46:14 -0700
Subject: [PATCH 03/10] ARM: dts: omap4: add bus functionality to base PRCM
 nodes
In-Reply-To: <20170920224621.16236-1-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
Message-ID: <20170920224621.16236-4-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <t-kristo@ti.com>

Add simple-bus compatibility and ranges properties to cm1, cm2 and prm
nodes. This is done in preparation of adding the support for clkctrl
nodes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -143,8 +143,11 @@
 			ranges = <0 0x4a000000 0x1000000>;
 
 			cm1: cm1 at 4000 {
-				compatible = "ti,omap4-cm1";
+				compatible = "ti,omap4-cm1", "simple-bus";
 				reg = <0x4000 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x4000 0x2000>;
 
 				cm1_clocks: clocks {
 					#address-cells = <1>;
@@ -156,8 +159,11 @@
 			};
 
 			cm2: cm2 at 8000 {
-				compatible = "ti,omap4-cm2";
+				compatible = "ti,omap4-cm2", "simple-bus";
 				reg = <0x8000 0x3000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x8000 0x3000>;
 
 				cm2_clocks: clocks {
 					#address-cells = <1>;
@@ -243,6 +249,9 @@
 					compatible = "ti,omap4-prm";
 					reg = <0x6000 0x3000>;
 					interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x6000 0x3000>;
 
 					prm_clocks: clocks {
 						#address-cells = <1>;
-- 
2.14.1
