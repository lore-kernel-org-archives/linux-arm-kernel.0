From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 11 Mar 2016 11:35:10 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4 xplained: don't disable hsmci regulator
Message-ID: <1457692516-3151-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If enabling the hsmci regulator on card detection, the board can reboot
on sd card insertion. Keeping the regulator always enabled fixes this
issue.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 8d545f32bd77 ("ARM: at91/dt: sama5d4 xplained: add regulators for
v(q)mmc1 supplies")
Cc: stable at vger.kernel.org #4.3 and later
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 569026e..da84e65 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -268,5 +268,6 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_3v3_reg>;
+		regulator-always-on;
 	};
 };
-- 
2.5.0
