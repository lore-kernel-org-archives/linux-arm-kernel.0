From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 10 Feb 2014 18:35:54 +0800
Subject: [PATCH v4 8/8] ARM: dts: sun7i: Add ethernet alias for GMAC
In-Reply-To: <1392028554-32545-1-git-send-email-wens@csie.org>
References: <1392028554-32545-1-git-send-email-wens@csie.org>
Message-ID: <1392028554-32545-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Allwinner A20 boards we support can only use either EMAC or GMAC,
as they share the same pins. As we have switched all supported to
GMAC, we should alias GMAC (the active controller) as ethernet0,
so u-boot will insert the MAC address for the correct controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 68c889c..1b5fb88 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -17,7 +17,7 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
-		ethernet0 = &emac;
+		ethernet0 = &gmac;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
1.9.rc1
