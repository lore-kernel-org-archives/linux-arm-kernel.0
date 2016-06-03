From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  3 Jun 2016 14:50:51 +0800
Subject: [PATCH v3 2/2] ARM: dts: sun9i: cubieboard4: Drop
 sunxi-common-regulators.dtsi
In-Reply-To: <1464936651-25911-1-git-send-email-wens@csie.org>
References: <1464936651-25911-1-git-send-email-wens@csie.org>
Message-ID: <1464936651-25911-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi-common-regulators.dtsi provided dummy regulators vcc3v0, vcc3v3,
vcc5v0. 3.0V/3.3V and 5.0V are commonly used voltages in Allwinner
devices. These dummy regulators provide a stand-in when bindings that
require one, but the real regulator is not supported yet.

Since these are no longer needed, we can drop the include file.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 8d8af1189d87..db770d06c31e 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -45,7 +45,6 @@
 
 /dts-v1/;
 #include "sun9i-a80.dtsi"
-#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
-- 
2.8.1
