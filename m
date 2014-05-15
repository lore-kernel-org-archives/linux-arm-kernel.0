From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 May 2014 16:23:52 +0200
Subject: [PATCH RFC 07/11] leds: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Message-ID: <1400163836-9831-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-leds at vger.kernel.org
---
 drivers/leds/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6de9dfbf61c1..01ebebfcc891 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -421,7 +421,7 @@ config LEDS_MC13783
 config LEDS_NS2
 	tristate "LED support for Network Space v2 GPIO LEDs"
 	depends on LEDS_CLASS
-	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD
 	default y
 	help
 	  This option enable support for the dual-GPIO LED found on the
@@ -431,7 +431,7 @@ config LEDS_NS2
 config LEDS_NETXBIG
 	tristate "LED support for Big Network series LEDs"
 	depends on LEDS_CLASS
-	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD
 	default y
 	help
 	  This option enable support for LEDs found on the LaCie 2Big
-- 
2.0.0.rc2
