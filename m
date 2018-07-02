From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon,  2 Jul 2018 15:21:43 -0500
Subject: [PATCH] ARM: dts: am335x-bone-common: Fix mmc0 Write Protect
Message-ID: <20180702202143.25343-1-robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mainline Commit b74c2b21e1551018af53ee6c1efc051dfce2d788 added the pinmux
settings for mmc1, however this pin (0x9a0) is routed to P9_42 on the cape
header. Thus any BeagleBone cape that utilizes P9_42 triggers mmc0's Write
Protect.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Faiz Abbas <faiz_abbas@ti.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index f9e8667f5886..73b514dddf65 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -168,7 +168,6 @@
 			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
 			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
 			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)		/* mcasp0_aclkr.mmc0_sdwp */
 		>;
 	};
 
-- 
2.18.0
