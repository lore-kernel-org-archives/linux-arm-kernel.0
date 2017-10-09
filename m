From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Mon,  9 Oct 2017 17:04:22 +0800
Subject: [PATCH v11 2/4] ARM: dts: rockchip: add RGA device node for RK3288
In-Reply-To: <20171009090424.15292-1-jacob-chen@iotwrt.com>
References: <20171009090424.15292-1-jacob-chen@iotwrt.com>
Message-ID: <20171009090424.15292-3-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the RGA dt config of rk3288 SoC.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index a0a0b08bff74..8c6dfc0abc42 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -972,6 +972,17 @@
 		status = "disabled";
 	};
 
+	rga: rga at ff920000 {
+		compatible = "rockchip,rk3288-rga";
+		reg = <0x0 0xff920000 0x0 0x180>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
+		clock-names = "aclk", "hclk", "sclk";
+		power-domains = <&power RK3288_PD_VIO>;
+		resets = <&cru SRST_RGA_CORE>, <&cru SRST_RGA_AXI>, <&cru SRST_RGA_AHB>;
+		reset-names = "core", "axi", "ahb";
+	};
+
 	vopb: vop at ff930000 {
 		compatible = "rockchip,rk3288-vop";
 		reg = <0x0 0xff930000 0x0 0x19c>;
-- 
2.14.1
