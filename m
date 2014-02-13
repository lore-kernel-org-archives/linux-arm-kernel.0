From: s-anna@ti.com (Suman Anna)
Date: Thu, 13 Feb 2014 12:22:54 -0600
Subject: [PATCH 2/4] ARM: dts: OMAP3: Add IVA IOMMU node
In-Reply-To: <1392315776-33197-1-git-send-email-s-anna@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Message-ID: <1392315776-33197-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Vaussard <florian.vaussard@epfl.ch>

Add the DT node for the IOMMU within the DSP subsystem. The entry
is disabled to keep in line with the current hwmod usage.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna at ti.com: split the entry and disable the node]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index ac91cc3..9607187 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -419,6 +419,15 @@
 			dma-window = <0 0xfffff000>;
 		};
 
+		mmu_iva: mmu at 5d000000 {
+			compatible = "ti,omap2-iommu";
+			reg = <0x5d000000 0x80>;
+			interrupts = <28>;
+			ti,hwmods = "mmu_iva";
+			dma-window = <0x11000000 0xeefff000>;
+			status = "disabled";
+		};
+
 		wdt2: wdt at 48314000 {
 			compatible = "ti,omap3-wdt";
 			reg = <0x48314000 0x80>;
-- 
1.8.5.3
