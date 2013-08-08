From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 10:50:02 +0200
Subject: [PATCH 6/6] ARM: at91/dt: remove old main clk definition from
 sama5d3xcm.dtsi
Message-ID: <1375951802-11060-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the old main clk node which is now useless as sama5d3
SoCs and boards are no longer compatible with the old at91 clk
implementations.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index f19d5bf..81c3957 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -18,17 +18,6 @@
 		reg = <0x20000000 0x20000000>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-	};
-
 	ahb {
 		apb {
 			spi0: spi at f0004000 {
-- 
1.7.9.5
