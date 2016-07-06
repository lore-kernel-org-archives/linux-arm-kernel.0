From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:44 +0800
Subject: [PATCH 3/9] ARM: dts: sun7i: lamobo-r1: Fix GPIO flags in reg_ahci_5v
In-Reply-To: <1467796250-22010-1-git-send-email-wens@csie.org>
References: <1467796250-22010-1-git-send-email-wens@csie.org>
Message-ID: <1467796250-22010-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reg_ahci_5v uses a GPIO in active high mode. Use the proper macro,
instead of just 0 for the GPIO flags.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 7307f07f82bd..c5126a9c35fc 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -249,7 +249,7 @@
 #include "axp209.dtsi"
 
 &reg_ahci_5v {
-	gpio = <&pio 1 3 0>; /* PB3 */
+	gpio = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
 	status = "okay";
 };
 
-- 
2.8.1
