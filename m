From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Thu, 27 Jul 2017 15:46:38 +0800
Subject: [PATCH] arm64: dts: rockchip: add rk3368 spdif node
Message-ID: <1501141598-53079-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the spdif dt node for rk3368 soc.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 6d5dc05..59c4158 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -700,6 +700,19 @@
 		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	spdif: spdif at ff880000 {
+		compatible = "rockchip,rk3368-spdif";
+		reg = <0x0 0xff880000 0x0 0x1000>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
+		clock-names = "mclk", "hclk";
+		dmas = <&dmac_bus 3>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		status = "disabled";
+	};
+
 	i2s_2ch: i2s-2ch at ff890000 {
 		compatible = "rockchip,rk3368-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff890000 0x0 0x1000>;
@@ -1024,6 +1037,12 @@
 			};
 		};
 
+		spdif {
+			spdif_tx: spdif-tx {
+				rockchip,pins =	<2 23 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		spi0 {
 			spi0_clk: spi0-clk {
 				rockchip,pins = <1 29 RK_FUNC_2 &pcfg_pull_up>;
-- 
2.7.4
