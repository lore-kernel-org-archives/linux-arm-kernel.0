From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 31 Mar 2014 17:39:58 +0200
Subject: [PATCH 1/6] ARM: socfpga: dts: fix pdma interrupt
Message-ID: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first interrupt is not at 180 but 104. Fix it.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 537f1a5..0c3344f 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -75,7 +75,7 @@
 			pdma: pdma at ffe01000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffe01000 0x1000>;
-				interrupts = <0 180 4>;
+				interrupts = <0 104 4>;
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
-- 
1.9.1
