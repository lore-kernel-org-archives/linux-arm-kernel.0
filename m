From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 22:54:10 +0200
Subject: [PATCH 4/5] ARM: dts: rockchip: drop unneeded properties from mipi
 node
In-Reply-To: <1459457651-4727-1-git-send-email-heiko@sntech.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
Message-ID: <1459457651-4727-5-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mipi controller node does contain an unused reg property as well as
unnecessary #address-cells and #size-cells properties for subnodes
not using addresses, so remove those to also make dtc happy.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ee4085d..9114c7b 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -888,10 +888,6 @@
 		status = "disabled";
 
 		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-
 			mipi_in: port {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.6.4
