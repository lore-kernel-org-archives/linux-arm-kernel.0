From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 15:27:09 -0800
Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
In-Reply-To: <1415032122-8230-1-git-send-email-balbi@ti.com>
References: <1415032122-8230-1-git-send-email-balbi@ti.com>
Message-ID: <20141110232709.GB31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141103 08:30]:
> by adding labels to DWC3 nodes, it's far easier
> for boards to reference them.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v3.19/dt, had to update it because
of "ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi". Updated
patch below.

Regards,

Tony

8< -------------------
From: Felipe Balbi <balbi@ti.com>
Date: Mon, 3 Nov 2014 10:28:42 -0600
Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes

by adding labels to DWC3 nodes, it's far easier
for boards to reference them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[tony at atomide.com: updated for otg 4 move to dra74x.dtsi]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1219,7 +1219,7 @@
 			};
 		};
 
-		omap_dwc3_1 at 48880000 {
+		omap_dwc3_1: omap_dwc3_1 at 48880000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss1";
 			reg = <0x48880000 0x10000>;
@@ -1240,7 +1240,7 @@
 			};
 		};
 
-		omap_dwc3_2 at 488c0000 {
+		omap_dwc3_2: omap_dwc3_2 at 488c0000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss2";
 			reg = <0x488c0000 0x10000>;
@@ -1262,7 +1262,7 @@
 		};
 
 		/* IRQ for DWC3_3 and DWC3_4 need IRQ crossbar */
-		omap_dwc3_3 at 48900000 {
+		omap_dwc3_3: omap_dwc3_3 at 48900000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss3";
 			reg = <0x48900000 0x10000>;
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -46,7 +46,7 @@
 	};
 
 	ocp {
-		omap_dwc3_4 at 48940000 {
+		omap_dwc3_4: omap_dwc3_4 at 48940000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss4";
 			reg = <0x48940000 0x10000>;
