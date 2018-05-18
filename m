From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:21 +0200
Subject: [PATCH 48/69] ARM: dts: gose: Drop unnecessary address properties
 from port nodes
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <c1eb7457ad6e9f3e2937f39ebfefb82cd729d625.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vin port nodes does not have an address and thus does not need
address-cells or address size-properties.

This is flagged by dtc as follows:
 # make dtbs W=1
 arch/arm/boot/dts/r8a7793-gose.dtb: Warning (avoid_unnecessary_addr_size): /soc/video at e6ef0000/port: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
 arch/arm/boot/dts/r8a7793-gose.dtb: Warning (avoid_unnecessary_addr_size): /soc/video at e6ef1000/port: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 7a66d885e657..ec94e2402bdf 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -759,9 +759,6 @@
 	pinctrl-names = "default";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		vin0ep2: endpoint {
 			remote-endpoint = <&adv7612_out>;
 			bus-width = <24>;
@@ -781,9 +778,6 @@
 	status = "okay";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		vin1ep: endpoint {
 			remote-endpoint = <&adv7180_out>;
 			bus-width = <8>;
-- 
2.11.0
