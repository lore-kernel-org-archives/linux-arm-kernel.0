From: briannorris@chromium.org (Brian Norris)
Date: Wed, 29 Nov 2017 15:35:41 -0800
Subject: [PATCH] arm64: dts: rockchip: add rk3399 DSI0 reset
Message-ID: <20171129233541.51337-1-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've documented this one already, but we didn't add it to the DTSI yet.

Suggested-by: Nickey Yang <nickey.yang@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c6dae25a3f23..8940a3dc3670 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1648,6 +1648,8 @@
 			 <&cru SCLK_DPHY_TX0_CFG>, <&cru PCLK_VIO_GRF>;
 		clock-names = "ref", "pclk", "phy_cfg", "grf";
 		power-domains = <&power RK3399_PD_VIO>;
+		resets = <&cru SRST_P_MIPI_DSI0>;
+		reset-names = "apb";
 		rockchip,grf = <&grf>;
 		status = "disabled";
 
-- 
2.15.0.531.g2ccb3012c9-goog
