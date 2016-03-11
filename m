From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 11 Mar 2016 11:43:39 +0100
Subject: [PATCH] ARM: at91/dt: sama5d3 xplained: don't disable hsmci regulator
Message-ID: <1457693033-3619-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If enabling the hsmci regulator on card detection, the board can reboot
on sd card insertion. Keeping the regulator always enabled fixes this
issue.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: 1b53e3416dd0 ("ARM: at91/dt: sama5d3 xplained: add fixed
regulator for vmmc0")
Cc: stable at vger.kernel.org #4.3 and later
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index d81474e..d4f5987 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -303,6 +303,7 @@
 		regulator-name = "mmc0-card-supply";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	gpio_keys {
-- 
2.5.0
