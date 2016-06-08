From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:33 +0900
Subject: [PATCH 03/30] ARM: dts: kzm9g: SCIFA4 supports RTS/CTS hardware flow
 control
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <d5bb5dcc584109323c4305e5e2a570aa1fa974ce.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On the KZM-A9-GT development board, the RTS and CTS pins of the debug
console SCIFA4 are wired to the CP2102 Serial-USB bridge.  Reflect
this in the DTS by adding the "uart-has-rtscts" property to the scifa4
device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index c2d8a080e392..9881adf1734e 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -378,6 +378,7 @@
 	pinctrl-0 = <&scifa4_pins>;
 	pinctrl-names = "default";
 
+	uart-has-rtscts;
 	status = "okay";
 };
 
-- 
2.1.4
