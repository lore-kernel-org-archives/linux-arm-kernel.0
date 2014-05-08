From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:27 +0200
Subject: [PATCH 2/2] input: atmel-wm97xx: only build for AVR32
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building this driver on ARM/at91 always gives us this error message:

drivers/input/touchscreen/atmel-wm97xx.c:63:2: error: #error Unknown CPU, this driver only supports AT32AP700X CPUs.

Clearly this configuration is not meant to work, so let's just prevent
it in Kconfig. If we ever want to use it on another platform, we should
also pass proper resources for GPIO, IRQ and memory, which are hardcoded
to AT32AP700X at the moment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input at vger.kernel.org
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index e2f0264..fe4c264 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -640,7 +640,7 @@ config TOUCHSCREEN_WM9713
 
 config TOUCHSCREEN_WM97XX_ATMEL
 	tristate "WM97xx Atmel accelerated touch"
-	depends on TOUCHSCREEN_WM97XX && (AVR32 || ARCH_AT91)
+	depends on TOUCHSCREEN_WM97XX && AVR32
 	help
 	  Say Y here for support for streaming mode with WM97xx touchscreens
 	  on Atmel AT91 or AVR32 systems with an AC97C module.
-- 
1.8.3.2
