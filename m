From: kever.yang@rock-chips.com (Kever Yang)
Date: Mon, 17 Nov 2014 22:55:38 +0800
Subject: [RFC PATCH 2/2] arm: dts: rockchip: select npll as parent of DCLK_VOP0
In-Reply-To: <1416236138-11010-1-git-send-email-kever.yang@rock-chips.com>
References: <1416236138-11010-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1416236138-11010-3-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DCLK_VOP0 will change the parent clock's rate, we don't want
to change the PLLs rate other than npll. So we select the npll
as parent directly.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index c3190f7..6ea6125 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -573,6 +573,8 @@
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		assigned-clocks = <&cru DCLK_VOP0>;
+		assigned-clock-parents = <3>;
 		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
 		reset-names = "axi", "ahb", "dclk";
 		iommus = <&vopb_mmu>;
-- 
1.9.1
