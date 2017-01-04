From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 4 Jan 2017 10:39:40 +0530
Subject: [PATCH] ARM: dts: am335x-icev2: Remove the duplicated pinmux setting
Message-ID: <20170104050940.25698-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no mmc sd card detect on am335x-ice board. But the spi0_cs1
pin being configured as mmcsd_cd. Removing it fixes the below warning
during boot.

[1.401303] pinctrl-single 44e10800.pinmux: pin 44e10960.0 already requested by 48030000.spi; cannot claim for 48060000.mmc

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Logs:
Before this patch: http://pastebin.ubuntu.com/23737509/
After this patch: http://pastebin.ubuntu.com/23737467/

 arch/arm/boot/dts/am335x-icev2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 1463df3b5b19..8ed46f9d79b7 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -170,7 +170,6 @@
 			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
 			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
 			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE5) /* (C15) spi0_cs1.mmc0_sdcd */
 		>;
 	};
 
-- 
2.11.0
