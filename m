From: s-anna@ti.com (Suman Anna)
Date: Tue, 21 Jul 2015 19:01:32 -0500
Subject: [PATCH 2/4] ARM: dts: DRA74x: Add dsp2_system syscon node
In-Reply-To: <1437523294-20058-1-git-send-email-s-anna@ti.com>
References: <1437523294-20058-1-git-send-email-s-anna@ti.com>
Message-ID: <1437523294-20058-3-git-send-email-s-anna@ti.com>
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
index fa995d0ca1f2..6cb112450ddd 100644
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
2.4.4
