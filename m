From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Apr 2018 12:29:47 +0200
Subject: [PATCH 06/10] ARM: dts: silk: Drop unnecessary address properties
 from vin port node
In-Reply-To: <20180426102951.8683-1-horms+renesas@verge.net.au>
References: <20180426102951.8683-1-horms+renesas@verge.net.au>
Message-ID: <20180426102951.8683-7-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vin port node does not have an address and thus does not need
address-cells or address size-properties.

This is flagged by dtc as follows:
 # make dtbs W=1
 arch/arm/boot/dts/r8a7794-silk.dtb: Warning (avoid_unnecessary_addr_size): /soc/video at e6ef0000/port: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index e2642d2c2eed..7808aaee6644 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -475,9 +475,6 @@
 	pinctrl-names = "default";
 
 	port {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		vin0ep: endpoint {
 			remote-endpoint = <&adv7180>;
 			bus-width = <8>;
-- 
2.11.0
