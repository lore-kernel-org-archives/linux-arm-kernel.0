From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Nov 2018 01:19:02 +0100
Subject: [PATCH] ARM: dts: rockchip: Remove @0 from the veyron memory node
Message-ID: <20181119001902.8565-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Coreboot version on veyron ChromeOS devices seems to ignore
memory at 0 nodes when updating the available memory and instead
inserts another memory node without the address.

This leads to 4GB systems only ever be using 2GB as the memory at 0
node takes precedence. So remove the @0 for veyron devices.

Fixes: 0b639b815f15 ("ARM: dts: rockchip: Add missing unit name to memory nodes in rk3288 boards")
Reported-by: Heikki Lindholm <holin@iki.fi>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 2075120cfc4d..d8bf939a3aff 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -10,7 +10,11 @@
 #include "rk3288.dtsi"
 
 / {
-	memory at 0 {
+	/*
+	 * The default coreboot on veyron devices ignores memory at 0 nodes
+	 * and would instead create another memory node.
+	 */
+	memory {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
-- 
2.18.0
