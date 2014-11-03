From: balbi@ti.com (Felipe Balbi)
Date: Mon, 3 Nov 2014 10:28:42 -0600
Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
Message-ID: <1415032122-8230-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

by adding labels to DWC3 nodes, it's far easier
for boards to reference them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

soon we will need to reference these nodes in order
to add extcon binding, so USB can be enabled out-of-the-box.

 arch/arm/boot/dts/dra7.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index b9bf09f..7b54d2b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1143,7 +1143,7 @@
 			};
 		};
 
-		omap_dwc3_1 at 48880000 {
+		omap_dwc3_1: omap_dwc3_1 at 48880000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss1";
 			reg = <0x48880000 0x10000>;
@@ -1164,7 +1164,7 @@
 			};
 		};
 
-		omap_dwc3_2 at 488c0000 {
+		omap_dwc3_2: omap_dwc3_2 at 488c0000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss2";
 			reg = <0x488c0000 0x10000>;
@@ -1186,7 +1186,7 @@
 		};
 
 		/* IRQ for DWC3_3 and DWC3_4 need IRQ crossbar */
-		omap_dwc3_3 at 48900000 {
+		omap_dwc3_3: omap_dwc3_3 at 48900000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss3";
 			reg = <0x48900000 0x10000>;
@@ -1206,7 +1206,7 @@
 			};
 		};
 
-		omap_dwc3_4 at 48940000 {
+		omap_dwc3_4: omap_dwc3_4 at 48940000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss4";
 			reg = <0x48940000 0x10000>;
-- 
2.1.0.GIT
