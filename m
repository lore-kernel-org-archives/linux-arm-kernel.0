From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 22 Jun 2016 10:16:06 +0800
Subject: [PATCH v2 3/4] ARM: dts: rockchip: add GMAC nodes for RK322x SoCs
In-Reply-To: <1466561768-29770-1-git-send-email-zhengxing@rock-chips.com>
References: <1466561768-29770-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466561768-29770-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the GMAC dt nodes for rk322x SoCs.


Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2: None

 arch/arm/boot/dts/rk322x.dtsi |   64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index d5626705..a9cbef9 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -415,6 +415,28 @@
 		status = "disabled";
 	};
 
+	gmac: eth at 30200000 {
+		compatible = "rockchip,rk3228-gmac";
+		reg = <0x30200000 0x10000>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
+			<&cru SCLK_MAC_TX>, <&cru SCLK_MAC_REF>,
+			<&cru SCLK_MAC_REFOUT>, <&cru ACLK_GMAC>,
+			<&cru PCLK_GMAC>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			"mac_clk_tx", "clk_mac_ref",
+			"clk_mac_refout", "aclk_mac",
+			"pclk_mac";
+		resets = <&cru SRST_GMAC>;
+		reset-names = "stmmaceth";
+		phy-mode = "rgmii";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rgmii_pins>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at 32010000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -499,6 +521,10 @@
 			bias-disable;
 		};
 
+		pcfg_pull_none_drv_12ma: pcfg-pull-none-drv-12ma {
+			drive-strength = <12>;
+		};
+
 		emmc {
 			emmc_clk: emmc-clk {
 				rockchip,pins = <2 7 RK_FUNC_2 &pcfg_pull_none>;
@@ -520,6 +546,44 @@
 			};
 		};
 
+		gmac {
+			rgmii_pins: rgmii-pins {
+				rockchip,pins = <2 14 RK_FUNC_1 &pcfg_pull_none>,
+						<2 12 RK_FUNC_1 &pcfg_pull_none>,
+						<2 25 RK_FUNC_1 &pcfg_pull_none>,
+						<2 19 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 18 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 22 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 23 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 9 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 13 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 17 RK_FUNC_1 &pcfg_pull_none>,
+						<2 16 RK_FUNC_1 &pcfg_pull_none>,
+						<2 21 RK_FUNC_2 &pcfg_pull_none>,
+						<2 20 RK_FUNC_2 &pcfg_pull_none>,
+						<2 11 RK_FUNC_1 &pcfg_pull_none>,
+						<2 8 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			rmii_pins: rmii-pins {
+				rockchip,pins = <2 14 RK_FUNC_1 &pcfg_pull_none>,
+						<2 12 RK_FUNC_1 &pcfg_pull_none>,
+						<2 25 RK_FUNC_1 &pcfg_pull_none>,
+						<2 19 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 18 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 13 RK_FUNC_1 &pcfg_pull_none_drv_12ma>,
+						<2 17 RK_FUNC_1 &pcfg_pull_none>,
+						<2 16 RK_FUNC_1 &pcfg_pull_none>,
+						<2 8 RK_FUNC_1 &pcfg_pull_none>,
+						<2 15 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			phy_pins: phy-pins {
+				rockchip,pins = <2 14 RK_FUNC_2 &pcfg_pull_none>,
+						<2 8 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.7.9.5
