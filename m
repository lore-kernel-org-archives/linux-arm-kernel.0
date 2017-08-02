From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Wed,  2 Aug 2017 11:19:46 +0800
Subject: [PATCH v5 5/6] ARM: dts: rockchip: add RGA device node for RK3399
In-Reply-To: <1501643987-27847-1-git-send-email-jacob-chen@iotwrt.com>
References: <1501643987-27847-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1501643987-27847-6-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the RGA dt config of RK3399 SoC.

Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8e6d1bd..0133a5f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1056,6 +1056,17 @@
 		status = "disabled";
 	};
 
+	rga: rga at ff680000 {
+		compatible = "rockchip,rk3399-rga";
+		reg = <0x0 0xff680000 0x0 0x10000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
+		reset-names = "core", "axi", "ahb";
+		power-domains = <&power RK3399_PD_RGA>;
+	};
+
 	efuse0: efuse at ff690000 {
 		compatible = "rockchip,rk3399-efuse";
 		reg = <0x0 0xff690000 0x0 0x80>;
-- 
2.7.4
