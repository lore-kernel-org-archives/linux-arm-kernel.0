From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  9 Dec 2017 01:07:37 +0100
Subject: [PATCH 2/3] arm64: dts: rockchip: add rk3328 mali gpu node
In-Reply-To: <20171209000738.32187-1-heiko@sntech.de>
References: <20171209000738.32187-1-heiko@sntech.de>
Message-ID: <20171209000738.32187-3-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the core gpu node for the rk3328, a Mali450MP2.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 41d61840fb99..4bff6422f4da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -543,6 +543,29 @@
 		status = "disabled";
 	};
 
+	gpu: gpu at ff300000 {
+		compatible = "rockchip,rk3328-mali", "arm,mali-450";
+		reg = <0x0 0xff300000 0x0 0x40000>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp",
+				  "gpmmu",
+				  "pp",
+				  "pp0",
+				  "ppmmu0",
+				  "pp1",
+				  "ppmmu1";
+		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
+		clock-names = "bus", "core";
+		resets = <&cru SRST_GPU_A>;
+		status = "disabled";
+	};
+
 	h265e_mmu: iommu at ff330200 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff330200 0 0x100>;
-- 
2.14.2
