From: s-anna@ti.com (Suman Anna)
Date: Fri, 28 Feb 2014 14:49:53 -0600
Subject: [PATCHv2 3/4] ARM: dts: OMAP4: Add IOMMU nodes
In-Reply-To: <1393620594-14957-1-git-send-email-s-anna@ti.com>
References: <1393620594-14957-1-git-send-email-s-anna@ti.com>
Message-ID: <1393620594-14957-4-git-send-email-s-anna@ti.com>
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
index d3f8a6e..ab7be95 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -461,6 +461,21 @@
 			dma-names = "tx", "rx";
 		};
 
+		mmu_dsp: mmu at 4a066000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x4a066000 0xff>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mmu_dsp";
+		};
+
+		mmu_ipu: mmu at 55082000 {
+			compatible = "ti,omap4-iommu";
+			reg = <0x55082000 0xff>;
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
