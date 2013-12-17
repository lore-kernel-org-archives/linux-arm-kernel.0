From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 17 Dec 2013 13:53:36 +0100
Subject: [PATCH 5/7] ARM: dts: Complete data for isp iommu
In-Reply-To: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1387284818-28739-6-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing information required to probe the iommu for the camera
subsystem.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99..610d084 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -371,11 +371,13 @@
 			dma-names = "tx", "rx";
 		};
 
-		mmu_isp: mmu at 480bd400 {
+		mmu_isp: mmu_isp at 480bd400 {
 			compatible = "ti,omap3-mmu-isp";
 			ti,hwmods = "mmu_isp";
 			reg = <0x480bd400 0x80>;
 			interrupts = <8>;
+			ti,#tlb-entries = <8>;
+			dma-window = <0 0xfffff000>;	/* IOVA start & length */
 		};
 
 		wdt2: wdt at 48314000 {
-- 
1.8.1.2
