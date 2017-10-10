From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Oct 2017 10:56:01 +0200
Subject: [PATCH] arm64: dts: rockchip: fix typo in iommu nodes
Message-ID: <20171010085648.1339605-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest dtc warns about an extraneous cell in the interrupt
property of two of the iommu device nodes:

Warning (interrupts_property): interrupts size is (16), expected multiple of 12 in /iommu at ff373f00
Warning (interrupts_property): interrupts size is (16), expected multiple of 12 in /iommu at ff900800

This removes the typo.

Fixes: cede4c79de28 ("arm64: dts: rockchip: add rk3368 iommu nodes")
Fixes: 49c82f2b7c5d ("arm64: dts: rockchip: add rk3328 iommu nodes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6d615cb6e64d..41d61840fb99 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -582,7 +582,7 @@
 	vop_mmu: iommu at ff373f00 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff373f00 0x0 0x100>;
-		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
 		#iommu-cells = <0>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 19fbaa5e7bdd..1070c8264c13 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -740,7 +740,7 @@
 	iep_mmu: iommu at ff900800 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff900800 0x0 0x100>;
-		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "iep_mmu";
 		#iommu-cells = <0>;
 		status = "disabled";
-- 
2.9.0
