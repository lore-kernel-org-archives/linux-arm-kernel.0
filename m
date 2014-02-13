From: s-anna@ti.com (Suman Anna)
Date: Thu, 13 Feb 2014 12:22:53 -0600
Subject: [PATCH 1/4] ARM: dts: OMAP3: Update ISP IOMMU node
In-Reply-To: <1392315776-33197-1-git-send-email-s-anna@ti.com>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com>
Message-ID: <1392315776-33197-2-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Vaussard <florian.vaussard@epfl.ch>

Update the IOMMU node for the camera subsystem as per the
OMAP IOMMU bindings.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
[s-anna at ti.com: corrected interrupt number]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a5fc83b..ac91cc3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -411,10 +411,12 @@
 		};
 
 		mmu_isp: mmu at 480bd400 {
-			compatible = "ti,omap3-mmu-isp";
-			ti,hwmods = "mmu_isp";
+			compatible = "ti,omap2-iommu";
 			reg = <0x480bd400 0x80>;
-			interrupts = <8>;
+			interrupts = <24>;
+			ti,hwmods = "mmu_isp";
+			ti,#tlb-entries = <8>;
+			dma-window = <0 0xfffff000>;
 		};
 
 		wdt2: wdt at 48314000 {
-- 
1.8.5.3
