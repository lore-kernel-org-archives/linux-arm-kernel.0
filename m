From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 15:04:56 +0800
Subject: [PATCH] arm64: dts: ls1046a: drop incomplete memory node
Message-ID: <1519455896-8924-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory node in fsl-ls1046a.dtsi has no 'reg' property, and causes
the dtc warning below.

Warning (unit_address_vs_reg): Node /memory at 80000000 has a unit name, but no reg property

This is clearly an incomplete memory node.  Let's drop it.  Either
a complete memory should be added, or bootloader needs to fill the node
as a whole.

Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Shaohui Xie <Shaohui.Xie@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 606ea496f24e..cbf4b3e15c17 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -129,10 +129,6 @@
 		};
 	};
 
-	memory at 80000000 {
-		device_type = "memory";
-	};
-
 	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
1.9.1
