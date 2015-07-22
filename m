From: s-anna@ti.com (Suman Anna)
Date: Tue, 21 Jul 2015 19:01:34 -0500
Subject: [PATCH 4/4] ARM: dts: DRA74x: Add IOMMU nodes for DSP2
In-Reply-To: <1437523294-20058-1-git-send-email-s-anna@ti.com>
References: <1437523294-20058-1-git-send-email-s-anna@ti.com>
Message-ID: <1437523294-20058-5-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DRA74x family of SoCs have a second DSP, that also has
two MMUs just like the DSP1 subsystem. Add the IOMMU nodes
for this DSP2 subsystem in disabled state to the DRA74x
specific DTS file, the nodes would need to be enabled
appropriately in the respective board DTS files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra74x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 6cb112450ddd..612cc7e13bab 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -76,6 +76,26 @@
 				dr_mode = "otg";
 			};
 		};
+
+		mmu0_dsp2: mmu at 41501000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x41501000 0x100>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu0_dsp2";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp2_system 0x0>;
+			status = "disabled";
+		};
+
+		mmu1_dsp2: mmu at 41502000 {
+			compatible = "ti,dra7-dsp-iommu";
+			reg = <0x41502000 0x100>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu1_dsp2";
+			#iommu-cells = <0>;
+			ti,syscon-mmuconfig = <&dsp2_system 0x1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.4.4
