From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Sep 2017 11:18:10 +0200
Subject: [PATCH v2 6/8] ARM: dts: rockchip: add rk322x gpu node
In-Reply-To: <20170915091812.13368-1-heiko@sntech.de>
References: <20170915091812.13368-1-heiko@sntech.de>
Message-ID: <20170915091812.13368-7-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3228/3229 uses a Mali400 GPU with two pixel processors.
This adds the core node for it, which can be enabled
in board devicetrees.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk322x.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 06814421eed2..c97287ebb0ea 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -558,6 +558,27 @@
 		status = "disabled";
 	};
 
+	gpu: gpu at 20000000 {
+		compatible = "rockchip,rk3228-mali", "arm,mali-400";
+		reg = <0x20000000 0x10000>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp",
+				  "gpmmu",
+				  "pp0",
+				  "pp0mmu",
+				  "pp1",
+				  "pp1mmu";
+		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
+		clock-names = "core", "bus";
+		resets = <&cru SRST_GPU_A>;
+		status = "disabled";
+	};
+
 	vpu_mmu: iommu at 20020800 {
 		compatible = "rockchip,iommu";
 		reg = <0x20020800 0x100>;
-- 
2.14.1
