From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 12 Jul 2018 01:50:47 -0400
Subject: [PATCH 2/3] arm: dts: zynq: Use gpio constants for the Zybo Z7 board
In-Reply-To: <20180712055049.5098-1-luaraneda@gmail.com>
References: <20180712055049.5098-1-luaraneda@gmail.com>
Message-ID: <20180712055049.5098-3-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include GPIO dt-bindings and use GPIO_ACTIVE_* constants
to improve readability

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-zybo-z7.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index bc81ebee50fe..b68a5e921464 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /dts-v1/;
 #include "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Zynq ZYBO Z7 Development Board";
@@ -24,7 +25,7 @@
 	usb_phy0: phy0 {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio0 46 1>;
+		reset-gpios = <&gpio0 46 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.18.0
