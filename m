From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 17 Mar 2017 11:09:39 +0200
Subject: [PATCHv2 7/9] ARM: dts: omap4: add bus functionality to base PRCM
 nodes
In-Reply-To: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
Message-ID: <1489741781-12816-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-bus compatibility and ranges properties to cm1, cm2 and prm
nodes. This is done in preparation of adding the support for clkctrl
nodes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 578c53f..0cbd6c1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -132,8 +132,11 @@
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
@@ -145,8 +148,11 @@
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
@@ -229,6 +235,9 @@
 					compatible = "ti,omap4-prm";
 					reg = <0x6000 0x3000>;
 					interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x6000 0x3000>;
 
 					prm_clocks: clocks {
 						#address-cells = <1>;
-- 
1.9.1
