From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  8 Jun 2012 11:36:45 +0200
Subject: [PATCH v2] ARM: iconnect: Remove include of removed
 linux/spi/orion_spi.h
Message-ID: <1339148205-29285-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3.5-rc1 fails to build when DT and iconnect is enabled because of
this now none existant include file.

Also remove the other two SPI include files, which are not needed
with the move to DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org>
---
 arch/arm/mach-kirkwood/board-iconnect.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
index 2222c57..b0d3cc4 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-kirkwood/board-iconnect.c
@@ -20,9 +20,6 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/orion_spi.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
-- 
1.7.10
