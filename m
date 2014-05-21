From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 21 May 2014 17:27:33 +0300
Subject: [Patch v4 4/5] ARM: dts: keystone: update reset node to work with
 reset driver
In-Reply-To: <1400682454-24535-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400682454-24535-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1400682454-24535-5-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keystone driver requires the next additional properties:

"ti,syscon-pll" - syscon register range used to access pll controller
		  registers in order to use reset control registers.
"ti,syscon-dev" - syscon register range used to access device state
		  control registers in order to use mux block
		  registers for all watchdogs.

"ti,wdt_list"	- option to declare what watchdog are used to reboot
		  the SoC, so set "0" WDT as default.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 8b899ba..783da60 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -78,7 +78,9 @@
 
 		rstctrl: reset-controller {
 			compatible = "ti,keystone-reset";
-			reg = <0x023100e8 4>;	/* pll reset control reg */
+			ti,syscon-pll = <&pllctrl>;
+			ti,syscon-dev = <&devctrl>;
+			ti,wdt_list = <0>;
 		};
 
 		/include/ "keystone-clocks.dtsi"
-- 
1.8.3.2
