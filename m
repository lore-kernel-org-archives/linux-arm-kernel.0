From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 13 Dec 2017 20:37:14 +0100
Subject: [PATCH 1/2] arm: dts: sun8i: a83t: remove leading zero from cpucfg
 node address
Message-ID: <20171213193715.31039-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will fix the following warning:
Warning (simple_bus_reg): Node /soc/cpucfg at 01700000 simple-bus unit address format error, expected "1700000"

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7b372acf4bf6..715719f9ea2e 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -377,7 +377,7 @@
 			#reset-cells = <1>;
 		};
 
-		cpucfg at 01700000 {
+		cpucfg at 1700000 {
 			compatible = "allwinner,sun9i-a80-cpucfg";
 			reg = <0x01700000 0x100>;
 		};
-- 
2.13.6
