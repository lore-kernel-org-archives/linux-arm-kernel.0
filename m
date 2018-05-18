From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:25 +0200
Subject: [PATCH 52/69] ARM: dts: kzm9d: Drop unnecessary address properties
 from gpio_keys node
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <715d571162e0956a332ef52c5ba465f4f7089746.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio_keys node does not have an address and thus does not need
address-cells or address size-properties.

This is flagged by dtc as follows:
 # make dtbs W=1
 arch/arm/boot/dts/emev2-kzm9d.dtb: Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index c238407133bf..0af44b7eadb9 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -34,9 +34,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		one {
 			debounce-interval = <50>;
 			wakeup-source;
-- 
2.11.0
