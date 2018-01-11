From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 11 Jan 2018 11:04:11 +0800
Subject: [PATCH] ARM64: dts: meson-axg: add RMII pins for ethernet controller
Message-ID: <20180111030411.197054-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comparing to RGMII interface, the RMII interface require few pins.
So it's worth describing them here.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a80632641b39..ab4a0e8bc446 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -251,6 +251,36 @@
 					gpio-ranges = <&pinctrl_periphs 0 0 86>;
 				};
 
+				eth_rmii_x_pins: eth-x-rmii {
+					mux {
+						groups = "eth_mdio_x",
+						       "eth_mdc_x",
+						       "eth_rgmii_rx_clk_x",
+						       "eth_rx_dv_x",
+						       "eth_rxd0_x",
+						       "eth_rxd1_x",
+						       "eth_txen_x",
+						       "eth_txd0_x",
+						       "eth_txd1_x";
+						function = "eth";
+					};
+				};
+
+				eth_rmii_y_pins: eth-y-rmii {
+					mux {
+						groups = "eth_mdio_y",
+						       "eth_mdc_y",
+						       "eth_rgmii_rx_clk_y",
+						       "eth_rx_dv_y",
+						       "eth_rxd0_y",
+						       "eth_rxd1_y",
+						       "eth_txen_y",
+						       "eth_txd0_y",
+						       "eth_txd1_y";
+						function = "eth";
+					};
+				};
+
 				eth_rgmii_x_pins: eth-x-rgmii {
 					mux {
 						groups = "eth_mdio_x",
-- 
2.15.1
