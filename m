From: zyw@rock-chips.com (Chris Zhong)
Date: Wed,  8 Nov 2017 17:50:41 +0800
Subject: [PATCH v2] ARM: dts: add reset property for rk3066a-rayeager emac phy
Message-ID: <1510134642-18797-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet phy of rk3066a-rayeager has a reset pin, it controlled by
GPIO1_D6, this pin should be pull down then pull up to reset the phy.
Add a reset-gpios property in phy0, make the phy can be reset when emac
power on.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2:
use a generic property for reset, and this patch follow these 2 pathes
from Geert Uytterhoeven <geert+renesas@glider.be>
http://patchwork.ozlabs.org/patch/828499/
http://patchwork.ozlabs.org/patch/828505/

 arch/arm/boot/dts/rk3066a-rayeager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 570157f..04c1f97 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -177,6 +177,7 @@
 
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
+		reset-gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.7.4
