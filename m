From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jun 2018 15:21:37 +0200
Subject: [PATCH] ARM: dts: rockchip: fix graph node unit address error from dtc
Message-ID: <20180617132137.30502-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The updated dtc emits a warning for the edp-panel of two rk3288 boards:
    Warning (graph_endpoint): /dp at ff970000/ports/port at 1/endpoint: graph node unit address error, expected "0"

Fix this by adding the necessary @0 to the endpoint node.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-evb.dtsi               | 2 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 39b61dce97ad..1c4dfd94e555 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -232,7 +232,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			edp_out_panel: endpoint {
+			edp_out_panel: endpoint at 0 {
 				reg = <0>;
 				remote-endpoint = <&panel_in_edp>;
 			};
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index b16d570ff029..acf5f8a2307d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -174,7 +174,7 @@
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			edp_out_panel: endpoint {
+			edp_out_panel: endpoint at 0 {
 				reg = <0>;
 				remote-endpoint = <&panel_in_edp>;
 			};
-- 
2.17.0
