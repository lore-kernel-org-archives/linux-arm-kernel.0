From: s-anna@ti.com (Suman Anna)
Date: Wed, 5 Mar 2014 18:24:18 -0600
Subject: [PATCH 09/10] ARM: dts: OMAP4: Add IOMMU nodes
In-Reply-To: <1394065459-16409-1-git-send-email-s-anna@ti.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
Message-ID: <1394065459-16409-10-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Vaussard <florian.vaussard@epfl.ch>

Add the IOMMU nodes for the DSP and IPU subsystems. The MMU
within the IPU sub-system also supports a bus error back
capability, not available on the DSP MMU.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna at ti.com: IPU bus error back addition]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..2b88d97 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -461,6 +461,21 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_dsp: mmu at 4a066000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x4a066000 0x100>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_dsp";
+		};
+
+		mmu_ipu: mmu at 55082000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x55082000 0x100>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_ipu";
+			ti,iommu-bus-err-back;
+		};
+
 		wdt2: wdt at 4a314000 {
 			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
 			reg = <0x4a314000 0x80>;
-- 
1.9.0
