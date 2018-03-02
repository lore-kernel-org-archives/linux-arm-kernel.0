From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  2 Mar 2018 15:02:45 +0100
Subject: [PATCH resend] ARM: dts: atlas7: Use generic uart-has-rtscts DT
 property
Message-ID: <1519999365-15201-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 7f60830ab1511d94 ("serial: sirf: Use generic
uart-has-rtscts DT property property"), the SiRF UART driver recognizes
the generic "uart-has-rtscts" DT property, deprecating the
vendor-specific "sirf,uart-has-rtscts" DT property. Hence replace the
latter by the former in all DTS files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/atlas7-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7-evb.dts b/arch/arm/boot/dts/atlas7-evb.dts
index 1e9cd1a8508e17c2..900e03b7a7b21011 100644
--- a/arch/arm/boot/dts/atlas7-evb.dts
+++ b/arch/arm/boot/dts/atlas7-evb.dts
@@ -73,7 +73,7 @@
 		btm {
 			uart6: uart at 11000000 {
 				status = "okay";
-				sirf,uart-has-rtscts;
+				uart-has-rtscts;
 			};
 		};
 
-- 
2.7.4
