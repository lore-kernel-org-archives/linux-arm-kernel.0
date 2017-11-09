From: robh@kernel.org (Rob Herring)
Date: Thu,  9 Nov 2017 16:35:35 -0600
Subject: [PATCH] arm: dts: rockchip: fix errors in IOMMU interrupts property
 cells
Message-ID: <20171109223535.17368-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupts property in the IOMMU node for Rockchip dts file has a
spurious extra cell causing a dtc warning:

Warning (interrupts_property): interrupts size is (16), expected multiple of 12 in /iommu at ff900800

Remove the extra cell.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/rk3288.dtsi            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 356ed1e62452..cd43235ca16f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -956,7 +956,7 @@
 	iep_mmu: iommu at ff900800 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff900800 0x0 0x40>;
-		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "iep_mmu";
 		#iommu-cells = <0>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index e0518b4bc6c2..7a63279a85c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -808,7 +808,7 @@
 	iep_mmu: iommu at ff900800 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff900800 0x0 0x100>;
-		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "iep_mmu";
 		#iommu-cells = <0>;
 		status = "disabled";
-- 
2.14.1
