From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat,  9 May 2015 22:54:30 +0200
Subject: [PATCH] imx27: dt: only map 1 Kbyte for fec registers
Message-ID: <1431204870-17233-1-git-send-email-tremyfr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the imx27 documentation, fec has a 1 Kbyte
memory space map, spitted in two regions of 512 bytes.
The first one for control/status registers, and the
second one for event/statistic registers. So, we don't
need to map 16 Kbyte for registers, 1 Kbyte is enough.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 6951b66..56bb917 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -533,7 +533,7 @@
 
 			fec: ethernet at 1002b000 {
 				compatible = "fsl,imx27-fec";
-				reg = <0x1002b000 0x4000>;
+				reg = <0x1002b000 0x400>;
 				interrupts = <50>;
 				clocks = <&clks IMX27_CLK_FEC_IPG_GATE>,
 					 <&clks IMX27_CLK_FEC_AHB_GATE>;
-- 
1.7.4.4
