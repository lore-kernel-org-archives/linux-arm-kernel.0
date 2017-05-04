From: marex@denx.de (Marek Vasut)
Date: Thu,  4 May 2017 12:27:20 +0200
Subject: [PATCH] ARM: dts: socfpga: Fix the ethernet clock phandle
Message-ID: <20170504102720.10545-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet block clock phandle must point to the clock node which
represents the clock which directly supply the ethernet block. This
is emac_x_clk , not emacx_clk , so fix this.

From: Pavel Machek <pavel@denx.de>
Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index b2674bdb8e6a..7e24dc8e82d4 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -557,7 +557,7 @@
 			interrupts = <0 115 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			clocks = <&emac0_clk>;
+			clocks = <&emac_0_clk>;
 			clock-names = "stmmaceth";
 			resets = <&rst EMAC0_RESET>;
 			reset-names = "stmmaceth";
@@ -575,7 +575,7 @@
 			interrupts = <0 120 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-			clocks = <&emac1_clk>;
+			clocks = <&emac_1_clk>;
 			clock-names = "stmmaceth";
 			resets = <&rst EMAC1_RESET>;
 			reset-names = "stmmaceth";
-- 
2.11.0
