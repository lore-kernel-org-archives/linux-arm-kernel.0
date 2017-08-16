From: kever.yang@rock-chips.com (Kever Yang)
Date: Wed, 16 Aug 2017 10:51:09 +0800
Subject: [PATCH] arm64: dts: rk3399: init vop clock rates
Message-ID: <1502851869-1736-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to init vop aclk and hclk incase the U-Boot does not do
the initialize.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 0b3acc9..a592c24 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1480,6 +1480,8 @@
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		assigned-clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+		assigned-clock-rates = <400000000>, <100000000>;
 		iommus = <&vopl_mmu>;
 		power-domains = <&power RK3399_PD_VOPL>;
 		resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
@@ -1525,6 +1527,8 @@
 		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		assigned-clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
+		assigned-clock-rates = <400000000>, <100000000>;
 		iommus = <&vopb_mmu>;
 		power-domains = <&power RK3399_PD_VOPB>;
 		resets = <&cru SRST_A_VOP0>, <&cru SRST_H_VOP0>, <&cru SRST_D_VOP0>;
-- 
1.9.1
