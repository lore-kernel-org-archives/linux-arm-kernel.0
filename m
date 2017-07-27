From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Thu, 27 Jul 2017 14:50:27 +0800
Subject: [PATCH] ARM: dts: rockchip: add spdif for rk322x SoCs
Message-ID: <1501138227-11796-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the spdif dt node for rk322x SoCs.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 arch/arm/boot/dts/rk322x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index f3e4ffd..b3b80e1 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -196,6 +196,20 @@
 		status = "disabled";
 	};
 
+	spdif: spdif at 100d0000 {
+		compatible = "rockchip,rk3228-spdif";
+		reg = <0x100d0000 0x1000>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF_8CH>;
+		clock-names = "mclk", "hclk";
+		dmas = <&pdma 10>;
+		#dma-cells = <1>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		status = "disabled";
+	};
+
 	i2s2: i2s2 at 100e0000 {
 		compatible = "rockchip,rk3228-i2s", "rockchip,rk3066-i2s";
 		reg = <0x100e0000 0x4000>;
@@ -835,6 +849,12 @@
 			};
 		};
 
+		spdif {
+			spdif_tx: spdif-tx {
+				rockchip,pins = <3 31 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		tsadc {
 			otp_gpio: otp-gpio {
 				rockchip,pins = <0 24 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.7.4
