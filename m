From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:32 +0900
Subject: [PATCH 02/30] ARM: dts: bockw: SCIF0 supports RTS/CTS hardware flow
 control
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <388e9f592c740409ffe55740771389f946796694.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On the BOCK-W development board, the RTS and CTS pins of the console
SCIF0 are wired to the "product serial" connector.  Reflect this in the
DTS by adding the "uart-has-rtscts" property to the scif0 device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index e0dab1464648..982a237ea622 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -223,6 +223,7 @@
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
 
+	uart-has-rtscts;
 	status = "okay";
 };
 
-- 
2.1.4
