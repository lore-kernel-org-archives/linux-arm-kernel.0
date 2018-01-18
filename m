From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 18 Jan 2018 19:52:45 +0800
Subject: [PATCH v4 07/13] ARM: dts: rockchip: add clocks in vop iommu nodes
In-Reply-To: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Message-ID: <20180118115251.5542-8-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks in vop iommu nodes, since we are going to control clocks in
rockchip iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3036.dtsi | 2 ++
 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 3b704cfed69a..95b0ebc7a40f 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -197,6 +197,8 @@
 		reg = <0x10118300 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
+		clocks = <&cru ACLK_LCDC>, <&cru SCLK_LCDC>, <&cru HCLK_LCDC>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 6102e4e7f35c..5132dd887297 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1026,6 +1026,8 @@
 		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopb_mmu";
+		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
 		power-domains = <&power RK3288_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -1074,6 +1076,8 @@
 		reg = <0x0 0xff940300 0x0 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
 		power-domains = <&power RK3288_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
-- 
2.11.0
