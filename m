From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  9 Sep 2016 15:48:23 +0800
Subject: [PATCH 5/6] arm64: dts: rockchip: add pd_sdioaudio power node for
 rk3399
In-Reply-To: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
References: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1473407303-7542-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1.add pd node for RK3399 Soc
2.create power domain tree
3.add qos node for domain
4.add the pd_sdioaudio consumers node

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e2ecad651cac..4b67a249b3bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -240,6 +240,7 @@
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -605,6 +606,7 @@
 		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -724,6 +726,11 @@
 		reg = <0x0 0xffa74000 0x0 0x20>;
 	};
 
+	qos_sdioaudio: qos at ffa76000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa76000 0x0 0x20>;
+	};
+
 	qos_hdcp: qos at ffa90000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa90000 0x0 0x20>;
@@ -888,6 +895,11 @@
 					pm_qos = <&qos_sd>;
 				};
 			};
+			pd_sdioaudio at RK3399_PD_SDIOAUDIO {
+				reg = <RK3399_PD_SDIOAUDIO>;
+				clocks = <&cru HCLK_SDIO>;
+				pm_qos = <&qos_sdioaudio>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
@@ -1281,6 +1293,7 @@
 		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_bus>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -1295,6 +1308,7 @@
 		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_8ch_bus>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -1308,6 +1322,7 @@
 		clocks = <&cru SCLK_I2S1_8CH>, <&cru HCLK_I2S1_8CH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_2ch_bus>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
@@ -1319,6 +1334,7 @@
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S2_8CH>, <&cru HCLK_I2S2_8CH>;
+		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		status = "disabled";
 	};
 
-- 
1.9.1
