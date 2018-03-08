From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Thu,  8 Mar 2018 17:48:05 +0800
Subject: [PATCH v6 15/17] arm64: dts: rockchip: add isp0 node for rk3399
In-Reply-To: <20180308094807.9443-1-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
Message-ID: <20180308094807.9443-16-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunqian Zheng <zhengsq@rock-chips.com>

rk3399 have two ISP, but we havn't test isp1, so just add isp0 at present.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 2605118d4b4c..14ed016f2fdd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1614,6 +1614,21 @@
 		status = "disabled";
 	};
 
+	isp0: isp0 at ff910000 {
+		compatible = "rockchip,rk3399-cif-isp";
+		reg = <0x0 0xff910000 0x0 0x4000>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_ISP0>,
+			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
+			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
+		clock-names = "clk_isp",
+			      "aclk_isp", "aclk_isp_wrap",
+			      "hclk_isp", "hclk_isp_wrap";
+		power-domains = <&power RK3399_PD_ISP0>;
+		iommus = <&isp0_mmu>;
+		status = "disabled";
+	};
+
 	isp0_mmu: iommu at ff914000 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
-- 
2.16.1
