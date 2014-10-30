From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Oct 2014 15:15:34 +0100
Subject: [PATCH] watchdog: at91rm9200: allow building when using device tree
Message-ID: <1414678534-2677-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building with device tree, ARCH_AT91RM9200 may not be selected. Allow
building that driver by also depending on ARCH_AT91.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e3d5bf0a5021..5445343ff2a1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -144,7 +144,7 @@ config ARM_SP805_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on ARCH_AT91RM9200
+	depends on ARCH_AT91RM9200 || ARCH_AT91
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
-- 
2.1.0
