From: marex@denx.de (Marek Vasut)
Date: Thu, 10 May 2018 16:37:26 +0200
Subject: [PATCH] ARM: dts: socfpga: Fix NAND controller clock supply
Message-ID: <20180510143726.8047-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Denali NAND x-clock should be supplied by nand_x_clk, not by
nand_clk. Fix this, otherwise the Denali driver gets incorrect
clock frequency information and incorrectly configures the NAND
timing.

Signed-off-by: Marek Vasut <marex@denx.de>
Fixes: d837a80d19 ("ARM: dts: socfpga: add nand controller nodes")
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d697f5062624..e719c20a0e65 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -750,7 +750,7 @@
 			reg-names = "nand_data", "denali_reg";
 			interrupts = <0x0 0x90 0x4>;
 			dma-mask = <0xffffffff>;
-			clocks = <&nand_clk>;
+			clocks = <&nand_x_clk>;
 			status = "disabled";
 		};
 
-- 
2.16.2
