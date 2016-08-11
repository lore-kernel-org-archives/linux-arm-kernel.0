From: roger.chen@rock-chips.com (Roger Chen)
Date: Thu, 11 Aug 2016 15:24:47 +0800
Subject: [PATCH 2/3] arm64: dts: rockchip: add GMAC dt nodes for rk3399 SoC
In-Reply-To: <1470900288-10109-1-git-send-email-roger.chen@rock-chips.com>
References: <1470900288-10109-1-git-send-email-roger.chen@rock-chips.com>
Message-ID: <1470900288-10109-3-git-send-email-roger.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ethernet GMAC dt notes for Rockchip RK3399 SoC.

Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a6dd623..76f3e44 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -199,6 +199,25 @@
 		};
 	};
 
+	gmac: ethernet at fe300000 {
+		compatible = "rockchip,rk3399-gmac";
+		reg = <0x0 0xfe300000 0x0 0x10000>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
+		<&cru SCLK_MAC_TX>, <&cru SCLK_MACREF>,
+		<&cru SCLK_MACREF_OUT>, <&cru ACLK_GMAC>,
+		<&cru PCLK_GMAC>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+				"mac_clk_tx", "clk_mac_ref",
+				"clk_mac_refout", "aclk_mac",
+				"pclk_mac";
+		resets = <&cru SRST_A_GMAC>;
+		reset-names = "stmmaceth";
+		status = "disabled";
+	};
+
 	sdio0: dwmmc at fe310000 {
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
@@ -955,6 +974,66 @@
 			drive-strength = <13>;
 		};
 
+		gmac {
+			rgmii_pins: rgmii-pins {
+			rockchip,pins =
+			/* mac_txclk */
+			<3 17 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_rxclk */
+			<3 14 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_mdio */
+			<3 13 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_txen */
+			<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_clk */
+			<3 11 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxdv */
+			<3 9 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_mdc */
+			<3 8 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxd1 */
+			<3 7 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxd0 */
+			<3 6 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_txd1 */
+			<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_txd0 */
+			<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_rxd3 */
+			<3 3 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxd2 */
+			<3 2 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_txd3 */
+			<3 1 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_txd2 */
+			<3 0 RK_FUNC_1 &pcfg_pull_none_13ma>;
+			};
+
+			rmii_pins: rmii-pins {
+			rockchip,pins =
+			/* mac_mdio */
+			<3 13 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_txen */
+			<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_clk */
+			<3 11 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxer */
+			<3 10 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxdv */
+			<3 9 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_mdc */
+			<3 8 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxd1 */
+			<3 7 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_rxd0 */
+			<3 6 RK_FUNC_1 &pcfg_pull_none>,
+			/* mac_txd1 */
+			<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+			/* mac_txd0 */
+			<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins =
-- 
1.9.1
