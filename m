From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  2 Jan 2018 08:57:17 +0100
Subject: [PATCH] ARM: dts: Delete bogus reference to the charlcd
Message-ID: <20180102075717.7374-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EB MP board probably has a character LCD but the board manual does
not really state which IRQ it has assigned to this device. The invalid
assignment was a mistake by me during submission of the DTSI where I was
looking for the reference, didn't find it and didn't fill it in.

Delete this for now: it can probably be fixed but that requires access
to the actual board for some trial-and-error experiments.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for next to fix the DTS
compiler noise it is generating.
---
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
index 7b8d90b7aeea..29b636fce23f 100644
--- a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
@@ -150,11 +150,6 @@
 	interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-&charlcd {
-	interrupt-parent = <&intc>;
-	interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
-};
-
 &serial0 {
 	interrupt-parent = <&intc>;
 	interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.14.3
