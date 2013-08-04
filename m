From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  4 Aug 2013 11:58:49 +0200
Subject: [PATCHv3 8/9] ARM: sun7i: a20-olinuxino: Enable UARTs muxing
In-Reply-To: <1375610330-18185-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375610330-18185-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375610330-18185-9-git-send-email-maxime.ripard@free-electrons.com>
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
index d339584..4d988df 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -20,14 +20,20 @@
 
 	soc at 01c00000 {
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
