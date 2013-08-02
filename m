From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  2 Aug 2013 12:02:52 +0200
Subject: [PATCHv2 8/9] ARM: sun7i: a20-olinuxino: Enable UARTs muxing
In-Reply-To: <1375437773-3211-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375437773-3211-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375437773-3211-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on the bootloader to mux the UART pins properly, do
it on our own and register the rightful pins for the A20-olinuxino in
the DT using pinctrl.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 29edf8b..96e8c56 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -20,14 +20,20 @@
 
 	soc at 01c20000 {
 		uart0: serial at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 
 		uart6: serial at 01c29800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart6_pins_a>;
 			status = "okay";
 		};
 
 		uart7: serial at 01c29c00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart7_pins_a>;
 			status = "okay";
 		};
 	};
-- 
1.8.3.4
