From: s-anna@ti.com (Suman Anna)
Date: Fri, 10 Jul 2015 12:28:55 -0500
Subject: [PATCH 1/2] ARM: dts: OMAP4: Add #iommu-cells property to IOMMUs
In-Reply-To: <1436549336-33456-1-git-send-email-s-anna@ti.com>
References: <1436549336-33456-1-git-send-email-s-anna@ti.com>
Message-ID: <1436549336-33456-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing #iommu-cells property to the DSP and IPU IOMMU nodes
for OMAP4 platforms. This property is required as per the generic
iommu binding.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index f884d6adb71e..7d31c6ff246f 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -551,6 +551,7 @@
 			reg = <0x4a066000 0x100>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_dsp";
+			#iommu-cells = <0>;
 		};
 
 		mmu_ipu: mmu at 55082000 {
@@ -558,6 +559,7 @@
 			reg = <0x55082000 0x100>;
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmu_ipu";
+			#iommu-cells = <0>;
 			ti,iommu-bus-err-back;
 		};
 
-- 
2.4.4
