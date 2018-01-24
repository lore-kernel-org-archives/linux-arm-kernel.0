From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 24 Jan 2018 18:35:10 +0800
Subject: [PATCH v5 07/13] ARM: dts: rockchip: add clocks in vop iommu nodes
In-Reply-To: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
Message-ID: <20180124103516.2571-8-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks in vop iommu nodes, since we are going to control clocks in
rockchip iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5:
Remove clk names.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3036.dtsi | 1 +
 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 3b704cfed69a..70fc72509fb2 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -197,6 +197,7 @@
 		reg = <0x10118300 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
+		clocks = <&cru ACLK_LCDC>, <&cru SCLK_LCDC>, <&cru HCLK_LCDC>;
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 6102e4e7f35c..e983ec13cd87 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1026,6 +1026,7 @@
 		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopb_mmu";
+		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		power-domains = <&power RK3288_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -1074,6 +1075,7 @@
 		reg = <0x0 0xff940300 0x0 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
 		power-domains = <&power RK3288_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
-- 
2.11.0
