From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:22 +0200
Subject: [PATCH 49/69] ARM: dts: koelsch: Drop unnecessary address properties
 from port nodes
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <778dff91e83da64c55dd7cbe3489793797a9775e.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vin port nodes does not have an address and thus does not need
address-cells or address size-properties.

This is flagged by dtc as follows:
 # make dtbs W=1
 arch/arm/boot/dts/r8a7791-koelsch.dtb: Warning (avoid_unnecessary_addr_size): /soc/video at e6ef0000/port: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
 arch/arm/boot/dts/r8a7791-koelsch.dtb: Warning (avoid_unnecessary_addr_size): /soc/video at e6ef1000/port: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fcdd0164142b..68e8272cb90e 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -849,9 +849,6 @@
 	pinctrl-names = "default";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		vin0ep2: endpoint {
 			remote-endpoint = <&adv7612_out>;
 			bus-width = <24>;
@@ -870,9 +867,6 @@
 	pinctrl-names = "default";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		vin1ep: endpoint {
 			remote-endpoint = <&adv7180>;
 			bus-width = <8>;
-- 
2.11.0
