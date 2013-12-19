From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 19 Dec 2013 11:30:54 +0100
Subject: [PATCH] ARM: socfpga: dts: add pl330 clock
Message-ID: <1387449054-27115-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pl330 dmac won't be added to the list of amba devices, as it doesn't have
a clock entry.
Add the clock.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Rebased to
	git://git.rocketboards.org/linux-socfpga-next.git next-dt

 arch/arm/boot/dts/socfpga.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 634950f..8920371 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -79,6 +79,8 @@
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
+				clocks = <&l4_main_clk>;
+				clock-names = "apb_pclk";
 			};
 		};
 
-- 
1.8.5.1
