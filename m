From: s-anna@ti.com (Suman Anna)
Date: Fri, 2 Oct 2015 18:23:23 -0500
Subject: [REPOST PATCH 2/4] ARM: dts: DRA74x: Add dsp2_system syscon node
In-Reply-To: <1443828205-18706-1-git-send-email-s-anna@ti.com>
References: <1443828205-18706-1-git-send-email-s-anna@ti.com>
Message-ID: <1443828205-18706-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSP_SYSTEM sub-module is a dedicated system control logic
module present within a DRA7 DSP processor sub-system. This
module is responsible for power management, clock generation
and connection to the device PRCM module.

Add a syscon node for this module for the DSP2 processor
sub-system. This is added as a syscon node as it is a common
configuration module that can be used by the different IOMMU
instances and the corresponding remoteproc device.

The node is added to the dra74x.dtsi file, as the DSP2 processor
subsystem is usually present only on the DRA74x variants of the
DRA7 SoC family.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra74x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index feea98e0a4b5..dfa29b7ba86a 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -52,6 +52,11 @@
 	};
 
 	ocp {
+		dsp2_system: dsp_system at 41500000 {
+			compatible = "syscon";
+			reg = <0x41500000 0x100>;
+		};
+
 		omap_dwc3_4: omap_dwc3_4 at 48940000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss4";
-- 
2.6.0
