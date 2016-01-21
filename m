From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 21 Jan 2016 13:26:38 +0800
Subject: [PATCH RFC 11/15] ARM: dts: sun8i: sina33: Enable hardware reset and
 HS-DDR for eMMC
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Message-ID: <1453354002-28366-12-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc2 has a special pin for eMMC hardware reset, which is controllable
from the controller. Add the "mmc-cap-hw-reset" property to denote that
this controller supports this function, and the pins are actually used.

Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 13ce68f06dd6..bd2a3beb4629 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -109,10 +109,13 @@
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
 &mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 	/* eMMC is missing pull-ups */
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
-- 
2.7.0.rc3
