From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Thu, 27 Jul 2017 16:16:03 +0800
Subject: [PATCH v1 1/2] arm64: dts: rockchip: add rk3328 i2s nodes
In-Reply-To: <1501143365-76104-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1501143365-76104-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1501143365-76104-2-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the i2s dt nodes for rk3328.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 0be96ce..f1a284b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -156,6 +156,39 @@
 		clock-output-names = "xin24m";
 	};
 
+	i2s0: i2s at ff000000 {
+		compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xff000000 0x0 0x1000>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S0_8CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&dmac 11>, <&dmac 12>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
+	i2s1: i2s at ff010000 {
+		compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xff010000 0x0 0x1000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S1_8CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&dmac 14>, <&dmac 15>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
+	i2s2: i2s at ff020000 {
+		compatible = "rockchip,rk3328-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xff020000 0x0 0x1000>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S2>, <&cru HCLK_I2S2_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&dmac 0>, <&dmac 1>;
+		dma-names = "tx", "rx";
+		status = "disabled";
+	};
+
 	grf: syscon at ff100000 {
 		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff100000 0x0 0x1000>;
-- 
2.7.4
