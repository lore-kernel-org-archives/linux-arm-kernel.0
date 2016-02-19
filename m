From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 19 Feb 2016 15:48:15 +0100
Subject: [PATCH] ARM: at91/dt: fix typo in sama5d2 pinmux descriptions
Message-ID: <1455893301-1760-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PIN_PA15 macro has the same value as PIN_PA14 so we were overriding PA14
mux/configuration.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Reported-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Fixes: 7f16cb676c00 ("ARM: at91/dt: add sama5d2 pinmux")
Cc: stable at vger.kernel.org #4.4 and later
---
 arch/arm/boot/dts/sama5d2-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
index 1afe246..b0c912fe 100644
--- a/arch/arm/boot/dts/sama5d2-pinfunc.h
+++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
@@ -90,7 +90,7 @@
 #define PIN_PA14__I2SC1_MCK		PINMUX_PIN(PIN_PA14, 4, 2)
 #define PIN_PA14__FLEXCOM3_IO2		PINMUX_PIN(PIN_PA14, 5, 1)
 #define PIN_PA14__D9			PINMUX_PIN(PIN_PA14, 6, 2)
-#define PIN_PA15			14
+#define PIN_PA15			15
 #define PIN_PA15__GPIO			PINMUX_PIN(PIN_PA15, 0, 0)
 #define PIN_PA15__SPI0_MOSI		PINMUX_PIN(PIN_PA15, 1, 1)
 #define PIN_PA15__TF1			PINMUX_PIN(PIN_PA15, 2, 1)
-- 
2.5.0
