From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri,  8 Mar 2013 08:18:56 -0300
Subject: [PATCH] ARM: sunxi: cubieboard: Add UART muxing
Message-ID: <1362741536-12632-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We previously relied on the bootloader to do the muxing of the UART for
the Cubieboard. Don't rely on it anymore and use pinctrl.

Also remove uart1, as it is not enabled by default and it's not exposed
on the board headers.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

This is a followup patch to Maxime Ripard's "Extend UART support for 
Allwinner SoCs" series.

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 88e2dc1..dc760d0 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -37,10 +37,8 @@
 		};
 
 		uart0: uart at 01c28000 {
-			status = "okay";
-		};
-
-		uart1: uart at 01c28400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
 	};
-- 
1.8.1.5
