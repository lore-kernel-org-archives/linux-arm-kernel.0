From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  1 Nov 2018 13:36:38 +0100
Subject: [PATCH v2 1/2] arm64: dts: rockchip: add missing address and size
 cells for rk3399 mipi dsi
Message-ID: <20181101123639.15560-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSI controllers are also the hosts of their dsi bus and therefore contain
nodes describing the attached panels with their reg properties containing
the virtual ids.

The dsi controller nodes on rk3399 lacked the #address-cells and #size-cells
for these subnodes, so add them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2: none

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index c88e603396f6..4ac7bf547916 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1720,6 +1720,8 @@
 		resets = <&cru SRST_P_MIPI_DSI0>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 
 		ports {
@@ -1754,6 +1756,8 @@
 		resets = <&cru SRST_P_MIPI_DSI1>;
 		reset-names = "apb";
 		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 
 		ports {
-- 
2.17.0
