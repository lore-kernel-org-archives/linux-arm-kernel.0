From: s-anna@ti.com (Suman Anna)
Date: Tue, 21 Jul 2015 19:01:31 -0500
Subject: [PATCH 1/4] ARM: dts: DRA7: Add dsp1_system syscon node
In-Reply-To: <1437523294-20058-1-git-send-email-s-anna@ti.com>
References: <1437523294-20058-1-git-send-email-s-anna@ti.com>
Message-ID: <1437523294-20058-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSP_SYSTEM sub-module is a dedicated system control logic
module present within a DRA7 DSP processor sub-system. This
module is responsible for power management, clock generation
and connection to the device PRCM module.

Add a syscon node for this module for the DSP1 processor
sub-system. This is added as a syscon node as it is a common
configuration module that can be used by the different IOMMU
instances and the corresponding remoteproc device.

The node is added to the common dra7.dtsi file, as the DSP1
processor sub-system is mostly common across all the variants
of the DRA7 SoC family.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25bcecbd..1c96729641b6 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -296,6 +296,11 @@
 			reg = <0x4a002e00 0x7c>;
 		};
 
+		dsp1_system: dsp_system at 40d00000 {
+			compatible = "syscon";
+			reg = <0x40d00000 0x100>;
+		};
+
 		sdma: dma-controller at 4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
2.4.4
